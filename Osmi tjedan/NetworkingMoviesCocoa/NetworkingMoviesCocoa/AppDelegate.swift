//
//  AppDelegate.swift
//  NetworkingMoviesCocoa
//
//  Created by Borna Ungar on 06.07.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let initialViewController = UINavigationController(rootViewController: MovieViewController(networkManager: NetworkManager()))
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = initialViewController
        return true
    }

}

