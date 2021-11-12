//
//  SongTableViewCell.swift
//  rx_example
//
//  Created by Zvonimir Medak on 04.03.2021..
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class SongTableViewCell: UITableViewCell {
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let artistImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(songName: String, artistName: String, artistImageUrl: String) {
        songNameLabel.text = songName
        artistLabel.text = artistName
        if let url = URL(string: artistImageUrl) {
            artistImageView.kf.setImage(with: url)
        }
    }
}

private extension SongTableViewCell {
    
    func setupUI() {
        contentView.addSubviews(views: songNameLabel, artistLabel, artistImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        songNameLabel.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
        }
        
        artistLabel.snp.makeConstraints { (maker) in
            maker.leading.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 0))
            maker.top.equalTo(songNameLabel.snp.bottom).inset(-8)
        }
        artistImageView.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(5)
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(30)
        }
    }
}
