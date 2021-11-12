//
//  ViewController.swift
//  Brojevi
//
//  Created by Borna Ungar on 05.06.2021..
//

import UIKit

class FirstViewController: UIViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Upiši palindrom"
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.textColor = .black
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .gray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Provjeri", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand-Medium", size: 21)
        button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = .systemBlue
        button.backgroundColor = UIColor(named: "Calypso")
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setAction()
    }
    
    private func setupUI() {
        title = "Palindrom"
        view.backgroundColor = .white
        view.addSubviews([textField, divider, button])
        self.hideKeyboardWhenTappedAround()
        setupConstraints()
    }

    private func setupConstraints() {
        
        
        
        let textFieldTopConstraint = textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 143)
        textFieldTopConstraint.priority = .defaultLow
        
        let buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 380)
        buttonBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            textFieldTopConstraint,
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.widthAnchor.constraint(equalToConstant: 360),
            
            divider.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            divider.widthAnchor.constraint(equalToConstant: 360),
            divider.heightAnchor.constraint(equalToConstant: 1),
        
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 25),
            button.heightAnchor.constraint(equalToConstant: 45),
            button.widthAnchor.constraint(equalToConstant: 265),
            buttonBottomConstraint
        ])
    }
    
    private func setAction() {
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    @objc private func submit() {
        let enteredString = textField.text
        checkPalindrom(string: enteredString)
    }
    
    public func checkPalindrom(string: String?) {
        guard let safeString = string else {return}
        let palindrom = safeString.lowercased().replacingOccurrences(of: " ", with: "")
        
        if checkIfEmptyOrNotWord(string: safeString) {
            displayAlert(title: "Netočno!", messagePart1: "Unos nije riječ. Pokušajte unijeti pravu\n", messagePart2: "riječ koja je ujedno i palindrom.", buttonMessage: "Pokušaj ponovno", textColor: UIColor.black, textFont: UIFont(name: "Quicksand-Bold", size: 13))
        } else {
        
        let length = palindrom.count/2
        
        for i in 0..<length {
                
            let start = palindrom.index(palindrom.startIndex, offsetBy: i)
            let end = palindrom.index(palindrom.endIndex, offsetBy: -1-i)
            
            if palindrom[start] != palindrom[end]{
                displayAlert(title: "Netočno!", messagePart1: "Riječ koju ste upisali nije palindrom!\n", messagePart2: "Pokušajte s drugom riječi.", buttonMessage: "Pokušaj ponovno", textColor: UIColor.red, textFont: UIFont(name: "Quicksand-Regular", size: 13))
            }
        }
        
            displayAlert(title: "Točno!", messagePart1: "Riječ koju ste upisali je palindrom!\n", messagePart2: "Znate li još koji palindrom?", buttonMessage: "Upiši drugi palindrom", textColor: UIColor.green, textFont: UIFont(name: "Quicksand-Regular", size: 13))
        }
    }
    
    func displayAlert(title:String, messagePart1:String, messagePart2:String, buttonMessage:String, textColor: UIColor, textFont: UIFont?) {
        
        var mutableString = NSMutableAttributedString()
        
        mutableString = NSMutableAttributedString(
            string: messagePart1 + messagePart2,
            attributes: [NSAttributedString.Key.font:UIFont(name: "Quicksand-Regular", size: 13)])
        
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: messagePart1.count, length: messagePart2.count))
        
        mutableString.addAttribute(NSAttributedString.Key.font, value: textFont, range: NSRange(location: messagePart1.count, length: messagePart2.count))

        var alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        alert.setValue(mutableString, forKey: "attributedMessage")

        alert.addAction(UIAlertAction(title: buttonMessage, style: .default, handler: { action in
            self.textField.text = ""
            self.dismiss(animated:true, completion: nil)
        }))

        self.present(alert, animated: true, completion: nil)

    }
    
    func checkIfEmptyOrNotWord(string:String) -> Bool {
        if string.isEmpty {
            return true
        } else {
            for c in string {
                if (!c.isLetter) {
                    return true
                }
            }
        }
        
        return false
    }
}
