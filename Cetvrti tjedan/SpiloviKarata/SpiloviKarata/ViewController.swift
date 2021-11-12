//
//  ViewController.swift
//  SpiloviKarata
//
//  Created by Borna Ungar on 10.06.2021..
//

import UIKit

class ViewController: UIViewController {
        
    private let card: UIImageView = {
        let cardView = UIImageView()
        cardView.image = #imageLiteral(resourceName: "Card")
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("KOCKAJ", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand-Medium", size: 21)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "Carnation")
        button.layer.cornerRadius = 23
        let icon = #imageLiteral(resourceName: "Dice")
        button.setImage(icon, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Upiši troznamenkasti ili veći broj"
        label.font = UIFont(name: "Quicksand-Regular", size: 13)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "Carnation")?.cgColor
        textField.placeholder = "123"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(named: "#EBEBEB")
        textField.font = UIFont(name: "Quicksand-Regular", size: 15)
        textField.textColor = UIColor(named: "Carnation")
        textField.keyboardType = .numberPad
        textField.setLeftPadding(5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setAction()
    }
    
    private func setupUI() {
        title = "Broj špilova karata"
        view.tintColor = UIColor(named: "Carnation")
        view.backgroundColor = .white
        view.addSubviews([card, textField, label, button])
        self.hideKeyboardWhenTappedAround()
        setupConstraints()
    }

    private func setupConstraints() {
        
        let cardTopConstraint = card.topAnchor.constraint(equalTo: view.topAnchor, constant: 113)
        cardTopConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([

            cardTopConstraint,
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.widthAnchor.constraint(equalToConstant: 63),
            card.heightAnchor.constraint(equalToConstant: 94.5),
            
            textField.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 15),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 75),
            textField.heightAnchor.constraint(equalToConstant: 45),
            
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 7),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 34),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 157),
            button.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
    }
    
    private func setAction() {
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    @objc private func submit() {
        let enteredString = textField.text
        checkNumber(string: enteredString)
    }

    private func checkNumber(string: String?){
        
        guard let safeString = string else {return}
        guard let safeInt = Int(safeString) else {return}
        
        if (safeInt < 100) {
            
            let alert = UIAlertController(title: "Netočan unos", message: "Broj koji ste unijeli mora biti najmanje troznamenkast", preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(
                title: "Pokušaj ponovno",
                style: .destructive,
                handler: { action in
                    self.dismiss(animated:true, completion: nil)}
            )
            
            alert.addAction(dismissAction)
            
            present(alert, animated: true, completion: nil)
            
        } else {
            
            let secondVC = SecondViewController(n: safeInt)
            navigationController?.pushViewController(secondVC, animated: false)
            
        }
        
    }

}
