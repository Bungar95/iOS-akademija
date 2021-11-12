//
//  ViewController.swift
//  Brojevi
//
//  Created by Borna Ungar on 05.06.2021..
//

import UIKit

class FirstViewController: UIViewController {
    
    private let label1: UILabel = {
        let label = UILabel()
        label.text = "Broj do kojeg igrači broje"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "DiSerria")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "Broj igrača koji će sudjelovati u igri"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "DiSerria")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.text = "Promjena smjera*"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "DiSerria")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.text = "Preskakanje igrača*"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "DiSerria")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label5: UILabel = {
        let label = UILabel()
        label.text = "* s kojim brojem trenutni broj igra mora biti djeljiv"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = UIColor(named: "DiSerria")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField1: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.placeholder = "Upiši broj"
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let textField2: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.placeholder = "Upiši broj"
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let textField3: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.placeholder = "Upiši broj"
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let textField4: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.placeholder = "Upiši broj"
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Rezultat".uppercased(), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "DiSerria")
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
        title = "Igra izgovaranja brojeva"
        view.backgroundColor = .white
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(FirstViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FirstViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubviews([label1, label2, label3, label4, label5, textField1, textField2, textField3, textField4, button])
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
        
        let label1TopConstraint = label1.topAnchor.constraint(equalTo: view.topAnchor, constant: 123)
        label1TopConstraint.priority = .defaultLow
        
        let buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        buttonBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            label1TopConstraint,
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            textField1.topAnchor.constraint(equalTo: label1.bottomAnchor),
            textField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textField1.widthAnchor.constraint(equalToConstant: 345),
            textField1.heightAnchor.constraint(equalToConstant: 45),
            
            label2.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 25),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            textField2.topAnchor.constraint(equalTo: label2.bottomAnchor),
            textField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textField2.widthAnchor.constraint(equalTo: textField1.widthAnchor),
            textField2.heightAnchor.constraint(equalTo: textField1.heightAnchor),
            
            label3.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 25),
            label3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            textField3.topAnchor.constraint(equalTo: label3.bottomAnchor),
            textField3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textField3.widthAnchor.constraint(equalTo: textField1.widthAnchor),
            textField3.heightAnchor.constraint(equalTo: textField1.heightAnchor),
            
            label4.topAnchor.constraint(equalTo: textField3.bottomAnchor, constant: 25),
            label4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            textField4.topAnchor.constraint(equalTo: label4.bottomAnchor),
            textField4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textField4.widthAnchor.constraint(equalTo: textField1.widthAnchor),
            textField4.heightAnchor.constraint(equalTo: textField1.heightAnchor),
            
            label5.topAnchor.constraint(equalTo: textField4.bottomAnchor),
            label5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            buttonBottomConstraint,
            button.widthAnchor.constraint(equalTo: view.widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 45)
            
        ])
    }
    
    private func setAction() {
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    @objc private func submit() {
        let enteredN = textField1.text
        let enteredPlayers = textField2.text
        let enteredDirection = textField3.text
        let enteredSkip = textField4.text
        let secondVC = SecondViewController(numberN: enteredN, playerNumber: enteredPlayers, directionNumber: enteredDirection, skipNumber: enteredSkip)
        //        navigationController?.pushViewController(secondVC, animated: false)
        self.present(secondVC, animated: true, completion: nil)
    }
}
