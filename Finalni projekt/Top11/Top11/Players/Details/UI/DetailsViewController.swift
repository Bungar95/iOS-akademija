//
//  DetailsViewController.swift
//  Top11
//
//  Created by Borna Ungar on 29.07.2021..
//

import Foundation
import UIKit
import Rswift
import SnapKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModel
    
    let singleCustomView: SinglePlayerView = {
        let view = SinglePlayerView()
        return view
    }()
    
    let playersLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandMedium(size: 18)
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        return label
    }()
    
    let teamCustomView: TeamView = {
        let view = TeamView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .lightGray
        return tv
    }()
    
    init(viewModel:DetailsViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfPlayerOrTeam()
    }
}

extension DetailsViewController {
    
    func checkIfPlayerOrTeam(){
        if(viewModel.data.player != nil){
            playerSetupUI()
            playerSetupConstraints()
        }else{
            if let team = self.viewModel.data.team {
                self.viewModel.getTeamStatistic(players: team)
                setupTableView()
                teamSetupUI()
                teamSetupConstraints()
            }
        }
    }
    
    func playerSetupUI(){
        
        view.addSubview(singleCustomView)
        
        if let playerTeamId = viewModel.data.player?.clubTeamId {
            let playerTeam = checkTeamName(id: playerTeamId)
            singleCustomView.playerTeam.text = "\(playerTeam)"
        }
        
        if let playerLeague = viewModel.data.player?.league {
            singleCustomView.playerLeague.text = "\(playerLeague)"
        }
        
        if let playerName =  viewModel.data.player?.knownAs{
            singleCustomView.playerName.text = "\(playerName)"
        }
        
        if let fullNameLabel: String = SinglePlayerView.init().playerFullName.text, let playerFullName =  viewModel.data.player?.fullName{
            singleCustomView.playerFullName.text = "\(fullNameLabel) \(playerFullName)"
        }
        
        if let positionLabel = SinglePlayerView.init().playerPosition.text, let playerPosition = viewModel.data.player?.position{
            checkPositionIcon(position: playerPosition)
            singleCustomView.playerPosition.text = "\(positionLabel) \(playerPosition)"
        }
        
        if let dobLabel: String = SinglePlayerView.init().playerDob.text, let playerBirthday =  viewModel.data.player?.birthday, let playerAge = viewModel.data.player?.age{
            singleCustomView.playerDob.text = "\(dobLabel) \(DateUtils.getDateOfBirthFromTimestamp(timestamp: (playerBirthday))) (\(playerAge))"
        }
        
        if let heightLabel: String = SinglePlayerView.init().playerHeight.text, let playerHeight =  viewModel.data.player?.height{
            singleCustomView.playerHeight.text = "\(heightLabel) \(playerHeight)"
        }
        
        if let weightLabel: String = SinglePlayerView.init().playerWeight.text, let playerWeight =  viewModel.data.player?.weight{
            singleCustomView.playerWeight.text = "\(weightLabel) \(playerWeight)"
        }
        
        if let nationalityLabel: String = SinglePlayerView.init().playerNationality.text, let playerNationality =  viewModel.data.player?.nationality{
            singleCustomView.playerWeight.text = "\(nationalityLabel) \(playerNationality)"
        }
        
        if let appearancesLabel: String = SinglePlayerView.init().playerAppearances.text, let playerAppearances =  viewModel.data.player?.appearancesOverall{
            singleCustomView.playerAppearances.text = "\(appearancesLabel) \(playerAppearances)"
        }
        
        if let cleanSheetsLabel: String = SinglePlayerView.init().playerCleanSheets.text, let playerCleanSheets =  viewModel.data.player?.cleanSheetsOverall{
            singleCustomView.playerCleanSheets.text = "\(cleanSheetsLabel) \(playerCleanSheets)"
        }
        
        if let goalsLabel: String = SinglePlayerView.init().playerGoals.text, let playerGoals =  viewModel.data.player?.goalsOverall{
            singleCustomView.playerGoals.text = "\(goalsLabel) \(playerGoals)"
        }
        
        if let assistsLabel: String = SinglePlayerView.init().playerAssists.text, let playerAssists =  viewModel.data.player?.assistsOverall{
            singleCustomView.playerAssists.text = "\(assistsLabel) \(playerAssists)"
        }
        
        if let cardsLabel: String = SinglePlayerView.init().playerCards.text, let playerCards =  viewModel.data.player?.cardsOverall{
            singleCustomView.playerCards.text = "\(cardsLabel) \(playerCards)"
        }
        
    }
    
    func setupTableView(){
        tableView.register(TeamDetailsTableViewCell.self, forCellReuseIdentifier: "teamDetailsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func teamSetupUI(){
        
        view.addSubviews(views: playersLabel, tableView)
        
        if let teamCount = self.viewModel.data.team?.count{
            
            playersLabel.text = "Players in team"
            
            if let ageLabel: String = TeamView.init().teamAge.text{
                teamCustomView.teamAge.text = "\(ageLabel) \(self.viewModel.teamAge/teamCount)"
            }
            
            if let heightLabel: String = TeamView.init().teamHeight.text{
                teamCustomView.teamHeight.text = String(format: "\(heightLabel) %.2f", Double(self.viewModel.teamHeight)/Double(teamCount))
            }
            
            if let weightLabel: String = TeamView.init().teamWeight.text{
                teamCustomView.teamWeight.text = String(format: "\(weightLabel) %.2f", Double(self.viewModel.teamWeight)/Double(teamCount))
            }
            
            if let appearancesLabel: String = TeamView.init().teamAppearances.text{
                teamCustomView.teamAppearances.text = "\(appearancesLabel) \(self.viewModel.teamAppearances)"
            }
            
            if let goalsLabel: String = TeamView.init().teamGoals.text{
                teamCustomView.teamGoals.text = "\(goalsLabel) \(self.viewModel.teamGoals)"
            }
            
            if let assistsLabel: String = TeamView.init().teamAssists.text{
                teamCustomView.teamAssists.text = "\(assistsLabel) \(self.viewModel.teamAssists)"
            }
            
            if let cardsLabel: String = TeamView.init().teamCards.text{
                teamCustomView.teamCards.text = "\(cardsLabel) \(self.viewModel.teamCards)"
            }
        }
        
    }
    
    func playerSetupConstraints(){
        singleCustomView.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func teamSetupConstraints(){
        
        playersLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playersLabel.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
    func checkTeamName(id: Int) -> String {
        guard let name = viewModel.teamNamesDictionary[id] else {return "Unknown"}
        return name
    }
}

extension DetailsViewController: IconDelegate {
    func checkPositionIcon(position: String) {
        switch(position){
        case "Goalkeeper":
            singleCustomView.playerImageView.backgroundColor = .systemYellow
            singleCustomView.playerImageView.image = #imageLiteral(resourceName: "gk").withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        case "Defender":
            singleCustomView.playerImageView.backgroundColor = .systemTeal
            singleCustomView.playerImageView.image = #imageLiteral(resourceName: "def").withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        case "Midfielder":
            singleCustomView.playerImageView.backgroundColor = .systemGreen
            singleCustomView.playerImageView.image = #imageLiteral(resourceName: "mid").withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        case "Forward":
            singleCustomView.playerImageView.backgroundColor = .systemRed
            singleCustomView.playerImageView.image = #imageLiteral(resourceName: "att").withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        default:
            singleCustomView.playerImageView.backgroundColor = .white
        }
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data.team?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "teamDetailsTableViewCell", for: indexPath) as? TeamDetailsTableViewCell, let player = viewModel.data.team?[indexPath.row] else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        cell.configureCell(playerName: player.knownAs)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return teamCustomView
    }
    
}
