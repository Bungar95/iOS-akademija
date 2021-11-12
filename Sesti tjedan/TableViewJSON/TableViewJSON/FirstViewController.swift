//
//  FirstViewController.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 25.06.2021..
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    let btnCounties: UIButton = {
        let button = UIButton()
        button.setTitle("Counties", for: UIControl.State.normal)
        button.backgroundColor = .systemTeal
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let btnFields: UIButton = {
        let button = UIButton()
        button.setTitle("Fields", for: UIControl.State.normal)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let btnFertiliser: UIButton = {
        let button = UIButton()
        button.setTitle("Fertilisers", for: UIControl.State.normal)
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let btnHealthStats: UIButton = {
        let button = UIButton()
        button.setTitle("Health Stats", for: UIControl.State.normal)
        button.backgroundColor = .systemOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let btnUser: UIButton = {
        let button = UIButton()
        button.setTitle("Users", for: UIControl.State.normal)
        button.backgroundColor = .systemPurple
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setAction()
    }
    
    func setupUI(){
        view.addSubview(btnCounties)
        view.addSubview(btnFields)
        view.addSubview(btnFertiliser)
        view.addSubview(btnHealthStats)
        view.addSubview(btnUser)
        setupConstraints()
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            btnFields.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnFields.bottomAnchor.constraint(equalTo: btnHealthStats.topAnchor, constant: -50),
            btnFields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            btnFields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            btnHealthStats.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnHealthStats.bottomAnchor.constraint(equalTo: btnCounties.topAnchor, constant: -50),
            btnHealthStats.leadingAnchor.constraint(equalTo: btnFields.leadingAnchor),
            btnHealthStats.trailingAnchor.constraint(equalTo: btnFields.trailingAnchor),
        
            btnCounties.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btnCounties.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnCounties.leadingAnchor.constraint(equalTo: btnFields.leadingAnchor),
            btnCounties.trailingAnchor.constraint(equalTo: btnFields.trailingAnchor),
            
            btnUser.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnUser.topAnchor.constraint(equalTo: btnCounties.bottomAnchor, constant: 50),
            btnUser.leadingAnchor.constraint(equalTo: btnFields.leadingAnchor),
            btnUser.trailingAnchor.constraint(equalTo: btnFields.trailingAnchor),
            
            btnFertiliser.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnFertiliser.topAnchor.constraint(equalTo: btnUser.bottomAnchor, constant: 50),
            btnFertiliser.leadingAnchor.constraint(equalTo: btnFields.leadingAnchor),
            btnFertiliser.trailingAnchor.constraint(equalTo: btnFields.trailingAnchor),
            
            
        ])
        
    }
    
    private func setAction() {
        btnCounties.addTarget(self, action: #selector(submitForCounties), for: .touchUpInside)
        btnFields.addTarget(self, action: #selector(submitForFields), for: .touchUpInside)
        btnFertiliser.addTarget(self, action: #selector(submitForFertilisers), for: .touchUpInside)
        btnHealthStats.addTarget(self, action:  #selector(submitForStats), for: .touchUpInside)
        btnUser.addTarget(self, action:  #selector(submitForUser), for: .touchUpInside)
    }
    
    @objc private func submitForCounties() {
        navigationController?.pushViewController(CountiesViewController(), animated: true)
    }
    
    @objc private func submitForFields() {
        navigationController?.pushViewController(FieldsViewController(), animated: true)
    }
    
    @objc private func submitForFertilisers() {
        navigationController?.pushViewController(FertiliserViewController(), animated: true)
    }
    
    @objc private func submitForStats() {
        navigationController?.pushViewController(HealthStatsViewController(), animated: true)
    }
    
    @objc private func submitForUser() {
        navigationController?.pushViewController(UserViewController(), animated: true)
    }
    
}
