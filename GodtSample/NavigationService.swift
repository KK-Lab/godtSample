//
//  NavigationRouter.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation
import UIKit

class NavigationService {
    var router: Router?
    static let sharedService = NavigationService()
}

extension NavigationService {
    // MARK: Public API
    
    func attachRouter(router: Router) {
        self.router = router
    }
}

extension NavigationService: Router {
    func installRootViewControllerIntoWindow(window: UIWindow) {
        self.router?.installRootViewControllerIntoWindow(window)
    }
    
    func showDetailsViewForRecipe(recipe: Recipe) {
        self.router?.showDetailsViewForRecipe(recipe)
    }
}