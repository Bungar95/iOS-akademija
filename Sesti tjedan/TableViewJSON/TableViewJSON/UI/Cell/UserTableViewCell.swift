//
//  UserTableViewCell.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 27.06.2021..
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dobLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(email: String, dob: String, location: String, isSecondSection: Bool) {
        emailLabel.text = email
        dobLabel.text = dob
        locationLabel.text = location
        if isSecondSection {
            contentView.backgroundColor = .link
        }
    }
}

private extension UserTableViewCell {
    
    func setupUI() {
        contentView.addSubview(emailLabel)
        contentView.addSubview(dobLabel)
        contentView.addSubview(locationLabel)

        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dobLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            dobLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dobLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 5),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
}
