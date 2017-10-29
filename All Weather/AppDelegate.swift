//
//  AppDelegate.swift
//  All Weather
//
//  Created by Michal Lučanský on 23.9.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataManager: MainWeatherViewModel?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let tabBarController = window?.rootViewController as? UITabBarController,
            let viewControllers = tabBarController.viewControllers {
            for viewController in viewControllers {
                if let fetchViewController = viewController as? MainWeatherViewController {
                    fetchViewController.bindModel()
                }
            }
        }
    }
}
