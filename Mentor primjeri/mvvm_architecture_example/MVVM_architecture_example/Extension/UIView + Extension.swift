//
//  UIView + Extension.swift
//  MVVM_architecture_example
//
//  Created by Zvonimir Medak on 04.03.2021..
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
