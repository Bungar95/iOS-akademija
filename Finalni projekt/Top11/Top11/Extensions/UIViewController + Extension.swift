//
//  UIViewController + Extension.swift
//  Top11
//
//  Created by Borna Ungar on 26.07.2021..
//

import Foundation
import UIKit
extension UIViewController {
    
    func showToast(message : String, font: UIFont? = R.font.quicksandMedium(size: 13) ?? UIFont.init(name: "Quicksand-Medium", size: 13), toastColor: UIColor = UIColor.white,
                   toastBackground: UIColor = UIColor.black) {
        let toastLabel = UILabel()
        toastLabel.textColor = toastColor
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 6
        toastLabel.backgroundColor = toastBackground
        
        toastLabel.clipsToBounds = true
        
        let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 16
        let toastHeight: CGFloat = 32
        
        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastWidth / 2),
                                  y: self.view.frame.height - (toastHeight * 3),
                                  width: toastWidth, height: toastHeight)
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.5, delay: 0.25, options: .autoreverse, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okey dokey", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
