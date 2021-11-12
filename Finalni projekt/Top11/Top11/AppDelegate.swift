//
//  AppDelegate.swift
//  Top11
//
//  Created by Borna Ungar on 26.07.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let initialViewController = UINavigationController(rootViewController: PlayersViewController(viewModel: PlayersViewModelImpl(playersRepository: PlayersRepositoryImpl(networkManager: NetworkManager()))))
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = initialViewController
        return true
    }
    
}
