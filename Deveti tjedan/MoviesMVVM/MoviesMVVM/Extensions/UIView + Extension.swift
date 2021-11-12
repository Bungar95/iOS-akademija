//
//  UIView + Extension.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 13.07.2021..
//

import Foundation
import UIKit
extension UIView {
    
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
