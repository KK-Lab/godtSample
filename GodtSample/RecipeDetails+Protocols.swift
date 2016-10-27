//
//  Details+Protocols.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation

protocol RecipeDetailsView: class {
    func setRecipe(recipe: RecipeDetails.RecipeData)
}

protocol RecipeDetailsPresenter: class {
    func getRecipe()
}