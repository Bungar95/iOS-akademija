//
//  DetailsViewModelImpl.swift
//  Top11
//
//  Created by Borna Ungar on 29.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class DetailsViewModelImpl: DetailsViewModel {
    
    var playerRelay = PublishRelay<Player>.init()
    var teamRelay = PublishRelay<[Player]>.init()
    
    var data: CustomTeam
    var teamNamesDictionary: [Int:String]
    
    var teamAge: Int = 0
    var teamHeight: Int = 0
    var teamWeight: Int = 0
    var teamAppearances: Int = 0
    var teamGoals: Int = 0
    var teamAssists: Int = 0
    var teamCards: Int = 0
    
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    
    init(data: CustomTeam, teamNamesDictionary: [Int:String]){
        self.data = data
        self.teamNamesDictionary = teamNamesDictionary
    }
    
    func getTeamStatistic(players: [Player]){
        players.forEach{ player in
            teamAge += player.age
            teamHeight += player.height
            teamWeight += player.weight
            teamAppearances += player.appearancesOverall
            teamGoals += player.goalsOverall
            teamAssists += player.assistsOverall
            teamCards += player.cardsOverall
        }
    }
    
}
