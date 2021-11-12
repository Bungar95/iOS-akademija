//
//  PlayersViewModel.swift
//  Top11
//
//  Created by Borna Ungar on 26.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol PlayersViewModel: AnyObject {
    
    var screenPlayerDataRelay: BehaviorRelay<[Player]> {get}
    var screenTeamsDataRelay: BehaviorRelay<[Team]> {get}
    
    var filterablePlayerDataRelay: BehaviorRelay<[Player]> {get}
    var filteredPlayerDataRelay: BehaviorRelay<[Player]> {get}
    var searchValue: BehaviorRelay<String> {get}
    
    var teamNames: [Int: String] {get set}
    var chosenPlayers: [Player] {get set}
    var favoritePlayerIds: [Int] {get set}
    var favoritePlayers: [Player] {get set}
    
    var sortBool: Bool {get set}
    var customTeams: [CustomTeam] {get set}
    
    var singlePlayerRelay: PublishRelay<Player> {get}
    var favoritedTeamRelay: BehaviorRelay<[Player]> {get}
    var currentTeamRelay: BehaviorRelay<[Player]> {get}
    var previousTeamRelay: BehaviorRelay<[Player]> {get}
    var finishedTeamRelay: PublishRelay<[Player]> {get}
    var customDetailsVCRelay: PublishRelay<CustomTeam> {get set}
    
    var loaderSubject: ReplaySubject<Bool> {get}
    var topViewSubject: ReplaySubject<String> {get}
    var sortFavoriteNameSubject: ReplaySubject<Bool> {get}
    var sortFavoritePositionSubject: ReplaySubject<Bool> {get}
    
    var loadPlayerDataSubject: ReplaySubject<()> {get}
    var loadTeamsSubject: ReplaySubject<()> {get}
    var searchValueSubject: ReplaySubject<String> {get}
    var filterValueSubject: ReplaySubject<[Player]> {get}
    var singlePlayerSubject: ReplaySubject<Player> {get}
    var currentTeamCountSubject: PublishSubject<Int> {get}
    
    func initializeViewModelObservables() -> [Disposable]
    func checkFavoriteStatus(playerId: Int) -> Bool
    func switchFavoriteStatus(player: Player)
}
