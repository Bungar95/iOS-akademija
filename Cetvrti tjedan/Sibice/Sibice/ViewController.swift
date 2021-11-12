//
//  ViewController.swift
//  Sibice
//
//  Created by Borna Ungar on 11.06.2021..
//

import UIKit

class ViewController: UIViewController {
    
    private let textField1: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Najveći rezultat"
        textField.keyboardType = .numberPad
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.textColor = .black
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let divider1: UIView = {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    private let textField2: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Broj šibica"
        textField.keyboardType = .numberPad
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.textColor = .black
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let divider2: UIView = {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Izračunaj", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand-Medium", size: 21)
        button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = .systemBlue
        button.backgroundColor = UIColor(named: "MatchBrown")
        button.layer.cornerRadius = 18
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
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
        title = "Šibice"
        view.backgroundColor = .white
        view.addSubviews([textField1, divider1, textField2, divider2, button])
        self.hideKeyboardWhenTappedAround()
        setupConstraints()
    }

    private func setupConstraints() {
        
        let textField1TopConstraint = textField1.topAnchor.constraint(equalTo: view.topAnchor, constant: 143)
        textField1TopConstraint.priority = .defaultLow
        
        let buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 380)
        buttonBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            textField1TopConstraint,
            textField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField1.heightAnchor.constraint(equalToConstant: 44),
            textField1.widthAnchor.constraint(equalToConstant: 360),
            
            divider1.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 7),
            divider1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            divider1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            divider1.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            textField2.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 20),
            textField2.leadingAnchor.constraint(equalTo: textField1.leadingAnchor),
            textField2.trailingAnchor.constraint(equalTo: textField1.trailingAnchor),
            textField2.heightAnchor.constraint(equalToConstant: 44),
            textField2.widthAnchor.constraint(equalToConstant: 360),
            
            divider2.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 7),
            divider2.leadingAnchor.constraint(equalTo: divider1.leadingAnchor),
            divider2.trailingAnchor.constraint(equalTo: divider1.trailingAnchor),
            divider2.widthAnchor.constraint(equalTo: divider1.widthAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1),
        
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 25),
            button.heightAnchor.constraint(equalToConstant: 45),
            button.widthAnchor.constraint(equalToConstant: 265),
            buttonBottomConstraint
            
            
        ])
    }
    
    private func setAction() {
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    @objc private func submit() {
        let enteredString1 = textField1.text
        let enteredString2 = textField2.text
        let secondVC = SecondViewController(enteredString1: enteredString1, enteredString2: enteredString2)
        navigationController?.pushViewController(secondVC, animated: false)
    }
}
