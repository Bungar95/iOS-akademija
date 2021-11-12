//
//  CropTableViewCell.swift
//  tableview_primjer
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation
import UIKit

class CropTableViewCell: UITableViewCell {
    
    let cropNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
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
    
    func configureCell(name: String, time: String, isSecondSection: Bool) {
        cropNameLabel.text = name
        timeLabel.text = time
        if isSecondSection {
            contentView.backgroundColor = .link
        }
    }
}

private extension CropTableViewCell {
    
    func setupUI() {
        contentView.addSubview(cropNameLabel)
        contentView.addSubview(timeLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cropNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            cropNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cropNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timeLabel.topAnchor.constraint(equalTo: cropNameLabel.bottomAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
