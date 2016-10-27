//
//  Router.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
    func installRootViewControllerIntoWindow(window: UIWindow)
    func showDetailsViewForRecipe(recipe: Recipe)
}