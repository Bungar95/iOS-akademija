//
//  ViewController.swift
//  Banka
//
//  Created by Borna Ungar on 11.06.2021..
//

import UIKit

class ViewController: UIViewController {
    
    private let bankClass = Bank()
    
    private let textField1: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Broj računa"
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.textColor = .black
        textField.keyboardType = .numberPad
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
        textField.placeholder = "Tip bankovnog računa"
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
    
    private let textField3: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Tip klijenta"
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.textColor = .black
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let divider3: UIView = {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Regular", size: 15)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Iskušaj sreću", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand-Medium", size: 21)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "Carnation")
        button.layer.cornerRadius = 18
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAddTargetIsNotEmptyTextFields()
        setAction()
        
    }
    
    private func setupUI() {
        title = "Banka"
        view.backgroundColor = .white
        view.addSubviews([textField1, textField2, textField3, divider1, divider2, divider3, label, button])
        self.hideKeyboardWhenTappedAround()
        setupConstraints()
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        button.isEnabled = false
        textField1.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
        textField2.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
        textField3.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
       }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {

        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)

        guard
            let t1 = textField1.text, !t1.isEmpty,
            let t2 = textField2.text, !t2.isEmpty,
            let t3 = textField3.text, !t3.isEmpty
                else {
                    self.button.isEnabled = false
                    self.label.textColor = .red
                    self.label.text = "Neki od unosa je prazan."
                    return
            }
        
        if (checkFirstFieldRequirement(t1: t1) && checkSecondFieldRequirement(t2: t2) && checkThirdFieldRequirement(t3: t3)) {
            self.button.isEnabled = true
            label.textColor = .green
            label.text = "Sve je ok, možeš iskušati sreću."
        } else {
            self.button.isEnabled = false
            label.textColor = .red
            label.text = "Neki od unosa nisu ispravni. Provjeri unose."
        }
        
    }
    
    private func checkFirstFieldRequirement(t1: String) -> Bool {
        if t1.count == 10 && t1.first == "0" && t1[t1.index(after: t1.startIndex)] == "4" {
            return true
        }else{
            return false
        }
    }
    
    private func checkSecondFieldRequirement(t2: String) -> Bool {
        switch t2.lowercased() {
        case "devizni", "ziro", "žiro", "tekuci", "tekući":
            return true
        default:
            return false
        }
    }
    
    private func checkThirdFieldRequirement(t3: String) -> Bool {
        switch t3.lowercased() {
        case "privatni", "fizicki", "fizički":
            return true
        default:
            return false
        }
    }

    private func setupConstraints() {
        
        let textFieldTopConstraint = textField1.topAnchor.constraint(equalTo: view.topAnchor, constant: 113)
        textFieldTopConstraint.priority = .defaultLow
        
        let buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        buttonBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            textFieldTopConstraint,
            textField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField1.heightAnchor.constraint(equalToConstant: 44),
            
            divider1.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 7),
            divider1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            divider1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            divider1.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            textField2.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 7),
            textField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField2.heightAnchor.constraint(equalToConstant: 44),
            
            divider2.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 7),
            divider2.heightAnchor.constraint(equalToConstant: 1),
            divider2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            divider2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            divider2.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15),
            
            textField3.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 7),
            textField3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            textField3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField3.heightAnchor.constraint(equalToConstant: 44),
            
            divider3.topAnchor.constraint(equalTo: textField3.bottomAnchor, constant: 7),
            divider3.heightAnchor.constraint(equalToConstant: 1),
            divider3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            divider3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            divider3.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15),
            
            label.topAnchor.constraint(equalTo: divider3.bottomAnchor, constant: 7),

            button.heightAnchor.constraint(equalToConstant: 45),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonBottomConstraint
        ])
    }
    
    private func setAction() {
        
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    @objc private func submit() {
        let enteredString = textField1.text
        let enteredString2 = textField2.text
        let enteredString3 = textField3.text
        
        switch bankClass.playGame(bankNumber: enteredString, account: enteredString2, client: enteredString3) {
        
        case 1:
            displayAlert(title: "Djeljiv broj", messagePart1: "Broj računa djeljiv je sa 6.\n", messagePart2: "Bravo", buttonMessage: "Sad sam pravi iOS dev", textColor: .green, textFont: UIFont(name: "Quicksand", size: 13))
        case 2:
            displayAlert(title: "Banka daruje milijun kuna!", messagePart1: "To zvuči nevjerojatno, zar ne?\n", messagePart2: "Šalimo se, ovo je samo vježba.", buttonMessage: "Prevarili ste me!", textColor: .black, textFont: UIFont(name: "Quicksand", size: 13))
        case 3:
            displayAlert(title: "Poticaj od milijun eura!", messagePart1: "Da je zaista tako, ne bi bio tu gdje si sada, zar ne?", messagePart2: "", buttonMessage: "Ne, ja hoću biti iOS dev!", textColor: .black, textFont: UIFont(name: "Quicksand", size: 13))
        case 4:
            displayAlert(title: "Više sreće drugi put", messagePart1: "Od svega, ti staviš ovakve unose... Pokušaj nešto drugo.", messagePart2: "", buttonMessage: "Nikad developera od mene", textColor: .black, textFont: UIFont(name: "Quicksand", size: 13))
        default:
            displayAlert(title: "Nešto u unosu je krivo", messagePart1: "Neki unosi su specifični", messagePart2: "", buttonMessage: "Ok, probat ću!", textColor: .black, textFont: UIFont(name: "Quicksand", size: 13))
        }
    }
    
    private func displayAlert(title:String, messagePart1:String, messagePart2:String, buttonMessage:String, textColor: UIColor, textFont: UIFont?) {
        
        var mutableString = NSMutableAttributedString()
        
        mutableString = NSMutableAttributedString(
            string: messagePart1 + messagePart2,
            attributes: [NSAttributedString.Key.font:UIFont(name: "Quicksand-Regular", size: 13)])
        
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: messagePart1.count, length: messagePart2.count))
        
        mutableString.addAttribute(NSAttributedString.Key.font, value: textFont, range: NSRange(location: messagePart1.count, length: messagePart2.count))

        var alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        alert.setValue(mutableString, forKey: "attributedMessage")

        alert.addAction(UIAlertAction(title: buttonMessage, style: .default, handler: { action in
            self.dismiss(animated:true, completion: nil)
        }))

        self.present(alert, animated: true, completion: nil)

    }
}
