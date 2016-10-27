//
//  RecipeService.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation

protocol RecipeService {
    func attachCallback(callback: ([Recipe]) -> Void)
    func getCachedRecipes()
    func getUpdatedRecipesFromServer()
}