//
//  Details+Presenter.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation

extension RecipeDetails {
    
    class Presenter {
        private let recipe: Recipe
        weak private var detailsView: RecipeDetailsView?
        
        init(detailsView: RecipeDetailsView, recipe: Recipe) {
            self.recipe = recipe
            self.detailsView = detailsView
        }
    }
}

extension RecipeDetails.Presenter: RecipeDetailsPresenter {
    func getRecipe() {
        self.detailsView?.setRecipe(self.recipe.detailsRecipeData)
    }
}