//
//  StatsTableViewCell.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 27.06.2021..
//

import Foundation
import UIKit

class StatsTableViewCell: UITableViewCell {
    
    let systolicLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let diastolicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let diabetesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
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
    
    func configureCell(sys: Int?, dia: Int?, diabetes: Int?, weight: Double, date: String, isSecondSection: Bool) {
        if let systolic = sys {
            systolicLabel.text = "Systolic bp: \(systolic)"
        }
        if let diastolic = dia {
            diastolicLabel.text = "Diastolic bp: \(diastolic)"
        }
        if let diabetes = diabetes {
            diabetesLabel.text = "Diabetes type: \(diabetes)"
        }
        weightLabel.text = "Weight: \(weight)"
        dateLabel.text = date
        if isSecondSection {
            contentView.backgroundColor = .link
        }
    }
}

private extension StatsTableViewCell {
    
    func setupUI() {
        contentView.addSubview(systolicLabel)
        contentView.addSubview(diastolicLabel)
        contentView.addSubview(diabetesLabel)
        contentView.addSubview(weightLabel)
        contentView.addSubview(dateLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            diabetesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            diabetesLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            
            weightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            weightLabel.topAnchor.constraint(equalTo: diabetesLabel.bottomAnchor, constant: 8),
            
            systolicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            systolicLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 8),
            
            diastolicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            diastolicLabel.topAnchor.constraint(equalTo: systolicLabel.bottomAnchor, constant: 8),
            diastolicLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
        ])
    }
}
