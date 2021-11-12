//
//  SinglePlayerView.swift
//  Top11
//
//  Created by Borna Ungar on 30.07.2021..
//

import Foundation
import UIKit
import SnapKit

class SinglePlayerView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
    }()
    
    lazy var playerName: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandBold(size: 20)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var playerFullName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    lazy var playerTeam: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerHeight: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerWeight: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerLeague: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerPosition: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerDob: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerNationality: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerAppearances: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerGoals: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerCleanSheets: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerCards: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var playerAssists: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .lightGray
        addSubview(containerView)
        containerView.addSubviews(views: playerImageView, playerName, playerTeam, playerFullName, playerHeight, playerWeight, playerLeague, playerPosition, playerDob, playerNationality, playerAppearances, playerGoals, playerAssists, playerCleanSheets, playerCards)
        
        playerFullName.text = "Full name:"
        playerHeight.text = "Height:"
        playerWeight.text = "Weigth:"
        playerPosition.text = "Position:"
        playerDob.text = "Dob:"
        playerNationality.text = "Nationality:"
        playerAppearances.text = "Appearances:"
        playerGoals.text = "Goals:"
        playerAssists.text = "Assists:"
        playerCards.text = "Cards received:"
        playerCleanSheets.text = "Clean Sheets (as club):"
        setupConstraints()
    }
    
    func setupConstraints(){
        
        containerView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        playerImageView.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(100)
            
        }
        
        playerName.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(playerImageView.snp.bottom).offset(5)
        }
        
        playerTeam.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(playerName.snp.bottom).offset(5)
        }
        
        playerLeague.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(playerTeam.snp.bottom).offset(5)
        }
        
        playerFullName.snp.makeConstraints{ (make) -> Void in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(playerLeague.snp.bottom).offset(15)
        }
        
        playerPosition.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerFullName.snp.bottom).offset(5)
        }
        
        playerDob.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerPosition.snp.bottom).offset(5)
        }
        
        playerNationality.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerDob.snp.bottom).offset(5)
        }
        
        playerHeight.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerNationality.snp.bottom).offset(5)
        }
        
        playerWeight.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerHeight.snp.bottom).offset(5)
        }
        
        playerAppearances.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerWeight.snp.bottom).offset(5)
        }
        
        playerGoals.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerAppearances.snp.bottom).offset(5)
        }
        
        playerAssists.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerGoals.snp.bottom).offset(5)
        }
        
        playerCleanSheets.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerAssists.snp.bottom).offset(5)
        }
        
        playerCards.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(playerCleanSheets.snp.bottom).offset(5)
        }
        
    }
    
}
