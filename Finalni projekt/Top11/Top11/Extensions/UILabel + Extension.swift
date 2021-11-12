//
//  UILabel + Extension.swift
//  Top11
//
//  Created by Borna Ungar on 27.07.2021..
//

import Foundation
import UIKit
extension UILabel {
    
    func shortenedPosition(position: String) -> String {
        switch position {
        case "Goalkeeper":
            return "GK"
        case "Defender":
            return "DEF"
        case "Midfielder":
            return "MID"
        case "Forward":
            return "ATK"
        default: return "Unknown"
        }
    }
}
