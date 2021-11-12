//
//  ViewController.swift
//  Predavanja
//
//  Created by Borna Ungar on 11.06.2021..
//

import UIKit

class ViewController: UIViewController {
    
    private let label1: UILabel = {
        let label = UILabel()
        label.text = "Trajanje malog odmora (u minutama)"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "Calypso")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "Trajanje velikog odmora (u minutama)"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "Calypso")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.text = "Nakon kojeg sata slijedi veliki odmor"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "Calypso")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.text = "Željeno vrijeme"
        
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "Calypso")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField1: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Upiši broj"
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.setLeftPadding(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let textField2: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Upiši broj"
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.setLeftPadding(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let textField3: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Upiši broj"
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.setLeftPadding(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let textField4: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Upiši željeno vrijeme (hh:mm)"
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.setLeftPadding(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Saznaj", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand-Medium", size: 21)
        button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = .systemBlue
        button.backgroundColor = UIColor(named: "DiSerria")
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var activeTextField : UITextField? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setAction()
    }
    
    private func setupUI() {
        title = "Šibice"
        view.backgroundColor = .white
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubviews([textField1, textField2, textField3, textField4, label1, label2, label3, label4, button])
        self.hideKeyboardWhenTappedAround()
        setupConstraints()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
    }

    private func setupConstraints() {
        
        let label1TopConstraint = label1.topAnchor.constraint(equalTo: view.topAnchor, constant: 113)
        label1TopConstraint.priority = .defaultLow
        
        let buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        buttonBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            label1TopConstraint,
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            textField1.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 7),
            textField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField1.heightAnchor.constraint(equalToConstant: 45),
            
            label2.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 7),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            textField2.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 7),
            textField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField2.heightAnchor.constraint(equalToConstant: 45),
            
            label3.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 7),
            label3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            textField3.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 7),
            textField3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField3.heightAnchor.constraint(equalToConstant: 45),
            
            
            label4.topAnchor.constraint(equalTo: textField3.bottomAnchor, constant: 7),
            label4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            textField4.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: 7),
            textField4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField4.heightAnchor.constraint(equalToConstant: 45),
            
            
            button.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttonBottomConstraint
            
        ])
    }
    
    private func setAction() {
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    @objc private func submit() {
        let smallBreak = textField1.text
        let bigBreak = textField2.text
        let bigBreakTime = textField3.text
        let inputTime = textField4.text
        let secondVC = SecondViewController(smallBreak: smallBreak, bigBreak: bigBreak, bigBreakTime: bigBreakTime, inputTime: inputTime)
        self.present(secondVC, animated: true, completion: nil)
    }
}
