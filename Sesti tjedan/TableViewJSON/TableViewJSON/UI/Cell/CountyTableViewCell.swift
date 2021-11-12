//
//  CountyTableViewCell.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 21.06.2021..
//

import Foundation
import UIKit

class CountyTableViewCell: UITableViewCell {
    
    let countyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let idLabel: UILabel = {
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
    
    func configureCell(name: String, id: Int, isSecondSection: Bool) {
        countyNameLabel.text = name
        idLabel.text = "County id: \(String(id))"
        if isSecondSection {
            contentView.backgroundColor = .link
        }
    }
}

private extension CountyTableViewCell {
    
    func setupUI() {
        contentView.addSubview(countyNameLabel)
        contentView.addSubview(idLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            countyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            countyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            countyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            idLabel.topAnchor.constraint(equalTo: countyNameLabel.bottomAnchor, constant: 8),
            idLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
