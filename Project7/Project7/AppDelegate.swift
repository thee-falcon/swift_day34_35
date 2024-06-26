//
//  AppDelegate.swift
//  Project7
//
//  Created by Omar Makran on 4/1/24.
//  Copyright © 2024 Omar Makran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // access the root view controller of the app's main window. If the root view controller is of type UITabBarController.
        if let tabBarController = window?.rootViewController as? UITabBarController {
            // find Main in story board, reference to the main storyboard named "Main" is created.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // and then uses that to instantiate the nav controller using the nav controller identifier.
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            // The tab bar item is created using the UITabBarItem initializer uses .topRated: system-defined tab bar item style.
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            tabBarController.viewControllers?.append(vc)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

