//
//  FieldTableViewCell.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 25.06.2021..
//

import Foundation
import UIKit

class FieldTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let surfaceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let unitLabel: UILabel = {
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
    
    func configureCell(name: String, id: Int, surface: String, unit: String, isSecondSection: Bool) {
        nameLabel.text = name
        idLabel.text = String(id)
        surfaceLabel.text = surface
        unitLabel.text = unit
        if isSecondSection {
            contentView.backgroundColor = .link
        }
    }
}

private extension FieldTableViewCell {
    
    func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(surfaceLabel)
        contentView.addSubview(unitLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 5),
            
            surfaceLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5),
            surfaceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            unitLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5),
            unitLabel.leadingAnchor.constraint(equalTo: surfaceLabel.trailingAnchor, constant: 5),
            unitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            
        ])
    }
}
