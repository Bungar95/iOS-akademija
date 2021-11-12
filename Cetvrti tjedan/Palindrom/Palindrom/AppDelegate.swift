//
//  AppDelegate.swift
//  Palindrom
//
//  Created by Borna Ungar on 07.06.2021..
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let initialViewController = UINavigationController(rootViewController: FirstViewController())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = initialViewController
        return true
    }
}

