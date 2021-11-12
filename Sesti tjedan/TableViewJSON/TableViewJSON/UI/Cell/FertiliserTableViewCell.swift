//
//  FertiliserTableViewCell.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 26.06.2021..
//

import Foundation
import UIKit

class FertiliserTableViewCell: UITableViewCell {
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 14)
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
    
    func configureCell(name: String, id: Int, productName: String, value: Double, isSecondSection: Bool) {
        productNameLabel.text = "Product name: \(productName)"
        productValueLabel.text = "Max value: \(value)"
        if isSecondSection {
            contentView.backgroundColor = .link
        }
    }
}

private extension FertiliserTableViewCell {
    
    func setupUI() {
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productValueLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            productValueLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5),
            productValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            productValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            
        ])
    }
}

