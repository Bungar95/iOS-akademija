//
//  TeamDetailsViewCell.swift
//  Top11
//
//  Created by Borna Ungar on 03.08.2021..
//

import Foundation
import UIKit
import SnapKit
class TeamDetailsTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 17)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(playerName: String) {
        nameLabel.text = playerName
    }
}

private extension TeamDetailsTableViewCell {
    
    func setupUI() {
        contentView.backgroundColor = .lightGray
        self.backgroundColor = .lightGray
        self.selectionStyle = .none
        
        contentView.addSubview(nameLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.trailing.equalToSuperview()
        }
    }
}
