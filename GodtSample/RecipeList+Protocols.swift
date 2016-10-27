//
//  List+Protocols.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation

protocol RecipeListView: class {
    func setRecipes(recipes: [RecipeList.RecipeData])
}

protocol RecipeListPresenter: class {
    func getRecipes()
    func updateRecipes()
    func filterRecipesWithText(text: String)
    func showDetailsForRecipeAtIndex(index: Int)
}