//
//  PlayersTableViewCell.swift
//  Top11
//
//  Created by Borna Ungar on 27.07.2021..
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import Rswift
import RxSwift

class PlayersTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    let spacer: UIView = {
        let spacer = UIView()
        spacer.backgroundColor = .white
        return spacer
    }()
    
    let playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
    }()
    
    let playerNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandBold(size: 17)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let playerPositionLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 13)
        label.textColor = .white
        label.textAlignment = .center
        label.transform = CGAffineTransform(rotationAngle:CGFloat.pi/2)
        return label
    }()
    
    let playerClubLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandMedium(size: 19)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let favoriteButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    var cellDisposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        cellDisposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(playerId: Int, playerName: String, playerPosition: String, playerClub: String, favoriteStatus: Bool) {
        playerNameLabel.text = playerName
        playerPositionLabel.text = playerPositionLabel.shortenedPosition(position: playerPosition)
        playerClubLabel.text = "\(playerClub)"
        checkPositionIcon(position: playerPosition)
        setButtons(id: playerId, favorite: favoriteStatus)
    }
    
    func setButtons(id: Int, favorite: Bool){
        
        favoriteButton.setImage(#imageLiteral(resourceName: "favoriteFalse"), for: .normal)
        favoriteButton.setImage(#imageLiteral(resourceName: "favoriteTrue"), for: .selected)
        
        if(favorite){
            favoriteButton.isSelected = true
        }else{
            favoriteButton.isSelected = false
        }
        
    }
}

private extension PlayersTableViewCell {
    
    func setupUI() {
        contentView.backgroundColor = .gray
        self.backgroundColor = .gray
        spacer.backgroundColor = .white
        self.selectionStyle = .none
        
        contentView.addSubviews(views: cellView, spacer)
        cellView.addSubviews(views: playerNameLabel, playerPositionLabel, playerClubLabel, playerImageView, favoriteButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
        }
        
        spacer.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cellView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        
        playerImageView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.leading.equalToSuperview()
            make.width.height.equalTo(70)
        }
        
        playerPositionLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(playerImageView.snp.trailing)
            make.trailing.equalTo(playerImageView.snp.trailing).offset(30)
        }
        
        playerNameLabel.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview().offset(-15)
            make.leading.equalTo(playerPositionLabel.snp.trailing).offset(5)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-5)
        }
        
        playerClubLabel.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview().offset(15)
            make.leading.equalTo(playerPositionLabel.snp.trailing).offset(5)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-5)
        }
        
        favoriteButton.snp.makeConstraints{ (make) -> Void in
            make.leading.equalTo(cellView.snp.trailing).offset(-35)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
        }
        
    }
}

extension PlayersTableViewCell: IconDelegate {
    func checkPositionIcon(position: String) {
        switch(position){
        case "Goalkeeper":
            playerImageView.backgroundColor = .systemYellow
            playerImageView.image = #imageLiteral(resourceName: "gk").withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        case "Defender":
            playerImageView.backgroundColor = .systemTeal
            playerImageView.image = #imageLiteral(resourceName: "def").withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        case "Midfielder":
            playerImageView.backgroundColor = .systemGreen
            playerImageView.image = #imageLiteral(resourceName: "mid").withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        case "Forward":
            playerImageView.backgroundColor = .systemRed
            playerImageView.image = #imageLiteral(resourceName: "att").withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        default:
            playerImageView.backgroundColor = .white
        }
    }
}
