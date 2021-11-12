//
//  TeamView.swift
//  Top11
//
//  Created by Borna Ungar on 03.08.2021..
//

import Foundation
import UIKit
import SnapKit

class TeamView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var statisticLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandMedium(size: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var teamHeight: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 18)
        return label
    }()
    
    lazy var teamWeight: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 18)
        return label
    }()
    
    lazy var teamAge: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 18)
        return label
    }()
    
    lazy var teamAppearances: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 18)
        return label
    }()
    
    lazy var teamGoals: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 18)
        return label
    }()
    
    lazy var teamCards: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 18)
        return label
    }()
    
    lazy var teamAssists: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 18)
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
        containerView.addSubviews(views: statisticLabel, teamHeight, teamWeight, teamAge, teamAppearances, teamGoals, teamAssists, teamCards)
        
        statisticLabel.text = "Team statistics"
        teamHeight.text = "Avg. Height:"
        teamWeight.text = "Avg. Weigth:"
        teamAge.text = "Avg. Age:"
        teamAppearances.text = "Total Appearances:"
        teamGoals.text = "Total Goals:"
        teamAssists.text = "Total Assists:"
        teamCards.text = "Total Cards Received:"
        setupConstraints()
    }
    
    func setupConstraints(){
        
        containerView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        statisticLabel.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        teamAge.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(statisticLabel.snp.bottom).offset(10)
        }
        
        teamHeight.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(teamAge.snp.bottom).offset(5)
        }
        
        teamWeight.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(teamHeight.snp.bottom).offset(5)
        }
        
        teamAppearances.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(teamWeight.snp.bottom).offset(5)
        }
        
        teamGoals.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(teamAppearances.snp.bottom).offset(5)
        }
        
        teamAssists.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(teamGoals.snp.bottom).offset(5)
        }
        
        teamCards.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview().offset(10)
            make.top.equalTo(teamAssists.snp.bottom).offset(5)
        }
    }
}
