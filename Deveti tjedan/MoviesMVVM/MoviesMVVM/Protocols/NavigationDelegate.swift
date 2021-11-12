//
//  NavigationDelegate.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 17.07.2021..
//

import Foundation
import UIKit
protocol NavigationDelegate: AnyObject {
    func pushNavigation(viewController: UIViewController)
}
