//
//  UIView + Extension.swift
//  Top11
//
//  Created by Borna Ungar on 26.07.2021..
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
