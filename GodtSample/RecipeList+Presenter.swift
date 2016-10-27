//
//  List+Presenter.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation

extension RecipeList {
    
    class Presenter {
        private let recipeService: RecipeService
        weak private var listView: RecipeListView?
        private var recipes: [Recipe] = []
        private var filteredRecipes: [Recipe] = []
        
        init(listView: RecipeListView, recipeService: RecipeService) {
            self.listView = listView
            self.recipeService = recipeService
            
            self.recipeService.attachCallback  { [weak self] in
                self?.recipes = $0
                self?.filteredRecipes = $0
                self?.listView?.setRecipes($0.map { $0.listRecipeData })
            }
        }
    }
}

extension RecipeList.Presenter: RecipeListPresenter {
    // MARK: ListPresenter protocol implementation

    func getRecipes() {
        self.recipeService.getCachedRecipes()
    }
    
    func updateRecipes() {
        self.recipeService.getUpdatedRecipesFromServer()
    }
    
    func filterRecipesWithText(text: String) {
        let recipes = self.recipes.filter { $0.title.containsString(text) } 
        self.filteredRecipes = text.isEmpty ? self.recipes : recipes
        
        self.listView?.setRecipes(self.filteredRecipes.map { $0.listRecipeData })
    }
    
    func showDetailsForRecipeAtIndex(index: Int) {
        NavigationService.sharedService.showDetailsViewForRecipe(self.filteredRecipes[index])
    }
}
