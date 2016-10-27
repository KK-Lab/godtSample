//
//  Recipe.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 23.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Recipe {
    private let id: Int
    let title: String
    let fullDescription: String
    let imageURL: String
    let ingredients: [String]
    
    var shortDescription: String {
        return self.fullDescription.substringToIndex(self.fullDescription.startIndex.advancedBy(150, limit: self.fullDescription.endIndex))
    }
}

extension Recipe: Decodable {
    static func decode(json: JSON) -> Recipe? {
        guard let
            id = json["id"].int,
            title = json["title"].string,
            description = json["description"].cleanString,
            imageURL = json["images"][0]["url"].string
        else {
            return nil
        }
        
        let ingredients: [String] = json["ingredients"].flatMap { $1["elements"].flatMap { $1["name"].string } }
        
        return Recipe(id: id, title: title, fullDescription: description, imageURL: imageURL, ingredients: ingredients)
    }
}

extension Recipe: CustomStringConvertible {
    var description: String {
        return "<Recipe: \n\tid: \(self.id); \n\ttitle: \(self.title); \n\tdescription: \(self.fullDescription); \n\timageURL: \(self.imageURL); \n\tingredients: \(self.ingredients)\n>"
    }
}

extension Recipe {
    // MARK: Create Recipe from RecipeEntity
    
    init(entity: RecipeEntity) {
        self.id = entity.id
        self.title = entity.title
        self.fullDescription = entity.fullDescription
        self.imageURL = entity.imageURL
        self.ingredients = entity.ingredients
    }
    
    // MARK: Build models from Recipe
    
    var entity: RecipeEntity {
        let entity = RecipeEntity()
        entity.id = self.id
        entity.title = self.title
        entity.fullDescription = self.fullDescription
        entity.imageURL = self.imageURL
        entity.ingredients = self.ingredients
        
        return entity
    }
    
    var listRecipeData: RecipeList.RecipeData {
        let imageURL = NSURL(string: self.imageURL) ?? NSURL()
        return RecipeList.RecipeData(title: self.title, shortDescription: self.shortDescription, imageURL: imageURL)
    }
    
    var detailsRecipeData: RecipeDetails.RecipeData {
        let imageURL = NSURL(string: self.imageURL) ?? NSURL()
        return RecipeDetails.RecipeData(title: self.title, fullDescription: self.fullDescription, imageURL: imageURL, ingredients: self.ingredients)
    }
}