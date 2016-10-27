//
//  RouterService.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import UIKit

class RouterService {
    private let navigationController: UINavigationController
    
    init() {
        let listViewController = RecipeList.ViewController()
        let listPresenter = RecipeList.Presenter(listView: listViewController, recipeService: RecipeNetworkService())
        listViewController.presenter = listPresenter
        self.navigationController = UINavigationController(rootViewController: listViewController)
    }
}

extension RouterService: Router {
    // MARK: Router protocol implementation
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func showDetailsViewForRecipe(recipe: Recipe) {
        let detailsViewController = RecipeDetails.ViewController()
        let detailsPresenter = RecipeDetails.Presenter(detailsView: detailsViewController, recipe: recipe)
        detailsViewController.presenter = detailsPresenter
        
        self.navigationController.pushViewController(detailsViewController, animated: true)
    }
}
