//
//  RecipeService.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class RecipeNetworkService {
    private var callback: (([Recipe]) -> Void)?
    private let databaseService: RealmDatabaseService
    
    init() {
        self.databaseService = RealmDatabaseService()
    }
}

extension RecipeNetworkService: RecipeService {
    // MARK: RecipeService protocol implementation
    
    func attachCallback(callback: ([Recipe]) -> Void) {
        self.callback = callback
    }
    
    func getCachedRecipes() {
        let recipes = self.databaseService.fetchEntities(RecipeEntity.self)?.loadToArray().map { Recipe(entity: $0) }
        self.callback?(recipes ?? [])
    }
    
    func getUpdatedRecipesFromServer() {
        let request = NSMutableURLRequest()
        request.timeoutInterval = 60
        request.HTTPMethod = HTTPMethod.GET.rawValue
        request.URL = NSURL(string: "http://www.godt.no/api/getRecipesListDetailed?tags=&size=thumbnail-medium&ratio=1&limit=50&from=0") ?? NSURL()
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData?, _, _) in
            if let data = data {
                let json = JSON(data: data)
                let recipes = json.map { Recipe.decode($1) }
                
                dispatch_async(dispatch_get_main_queue(), {
                    let filteredRecipes = recipes.flatMap { $0 }
                    let entities = filteredRecipes.map { $0.entity }
                    
                    self.databaseService.addEntities(entities)
                    self.callback?(filteredRecipes)
                })
            }
        }).resume()
    }
}
