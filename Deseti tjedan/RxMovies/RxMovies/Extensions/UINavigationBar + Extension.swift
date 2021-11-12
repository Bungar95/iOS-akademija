//
//  UINavigationBar + Extension.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 18.07.2021..
// https://stackoverflow.com/questions/21823692/how-to-prevent-uinavigationbar-from-blocking-touches-on-view/22365191

import Foundation
import UIKit
extension UINavigationBar {
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard nestedInteractiveViews(in: self, contain: point) else { return false }
        return super.point(inside: point, with: event)
    }
    
    private func nestedInteractiveViews(in view: UIView, contain point: CGPoint) -> Bool {
        if view.isPotentiallyInteractive, view.bounds.contains(convert(point, to: view)) {
            return true
        }
        
        for subview in view.subviews {
            if nestedInteractiveViews(in: subview, contain: point) {
                return true
            }
        }
        
        return false
    }
}

private extension UIView {
    var isPotentiallyInteractive: Bool {
        guard isUserInteractionEnabled else { return false }
        return (isControl || doesContainGestureRecognizer)
    }
    
    var isControl: Bool {
        return self is UIControl
    }
    
    var doesContainGestureRecognizer: Bool {
        return !(gestureRecognizers?.isEmpty ?? true)
    }
}
