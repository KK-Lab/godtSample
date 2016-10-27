//
//  AppDelegate.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 23.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        NavigationService.sharedService.attachRouter(RouterService())
        NavigationService.sharedService.installRootViewControllerIntoWindow(window)
        self.window = window
        
        return true
    }
}

