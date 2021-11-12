//
//  PlayersViewModelImpl.swift
//  Top11
//
//  Created by Borna Ungar on 26.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PlayersViewModelImpl: PlayersViewModel {
    
    var screenPlayerDataRelay = BehaviorRelay<[Player]>.init(value: [])
    var screenTeamsDataRelay = BehaviorRelay<[Team]>.init(value: [])
    
    var filterablePlayerDataRelay = BehaviorRelay<[Player]>.init(value: [])
    var filteredPlayerDataRelay = BehaviorRelay<[Player]>.init(value: [])
    var searchValue = BehaviorRelay<String>.init(value: "")
    
    var singlePlayerRelay = PublishRelay<Player>.init()
    var currentTeamRelay = BehaviorRelay<[Player]>.init(value: [])
    var previousTeamRelay = BehaviorRelay<[Player]>.init(value: [])
    var finishedTeamRelay = PublishRelay<[Player]>.init()
    var favoritedTeamRelay = BehaviorRelay<[Player]>.init(value: [])
    var customDetailsVCRelay = PublishRelay<CustomTeam>.init()
    
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var topViewSubject = ReplaySubject<String>.create(bufferSize: 1)
    var loadPlayerDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    var loadTeamsSubject = ReplaySubject<()>.create(bufferSize: 1)
    var currentTeamCountSubject = PublishSubject<Int>.init()
    
    var searchValueSubject = ReplaySubject<String>.create(bufferSize: 1)
    var filterValueSubject = ReplaySubject<[Player]>.create(bufferSize: 1)
    
    var singlePlayerSubject = ReplaySubject<Player>.create(bufferSize: 1)
    var teamSubject = ReplaySubject<[Player]>.create(bufferSize: 1)
    
    var teamNames: [Int: String] = [:]
    var chosenPlayers: [Player] = []
    var customTeams: [CustomTeam] = []
    
    var favoritePlayerIds: [Int] = []
    var favoritePlayers: [Player] = []
    
    var sortFavoriteNameSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var sortFavoritePositionSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var sortBool = true
    
    private let playersRepository: PlayersRepository
    
    init(playersRepository: PlayersRepository) {
        self.playersRepository = playersRepository
        self.favoritePlayerIds = UserDefaults.standard.array(forKey: "favoritePlayers") as? [Int] ?? []
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeTeamNamesSubject(subject: loadTeamsSubject))
        disposables.append(initializeLoadPlayersSubject(subject: loadPlayerDataSubject))
        disposables.append(initializeSearchSubject(subject: searchValueSubject))
        return disposables
    }
    
    func checkFavoriteStatus(playerId: Int) -> Bool {
        return favoritePlayerIds.contains(playerId)
    }
    
    func switchFavoriteStatus(player: Player){
        if(favoritePlayerIds.contains(player.id)){
            favoritePlayerIds.removeObject(object: player.id)
            favoritePlayers.removeObject(object: player)
            favoritedTeamRelay.accept(favoritePlayers)
        }else{
            favoritePlayerIds.append(player.id)
            favoritePlayers.append(player)
            favoritedTeamRelay.accept(favoritePlayers)
        }
        UserDefaults.standard.setValue(favoritePlayerIds, forKey: "favoritePlayers")
    }
    
}

private extension PlayersViewModelImpl {
    
    func initializeTeamNamesSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<TeamsResponse> in
                self.loaderSubject.onNext(true)
                return self.playersRepository.getTeams()
            }
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (teamsResponse) in
                let teams = teamsResponse.data
                self.screenTeamsDataRelay.accept(teams)
                self.loaderSubject.onNext(false)
            })
    }
    
    func initializeLoadPlayersSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<PlayersResponse> in
                self.loaderSubject.onNext(true)
                return self.playersRepository.getPlayers()
            }
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (playersResponse) in
                let players = playersResponse.data
                self.screenPlayerDataRelay.accept(players)
                self.filterablePlayerDataRelay.accept(self.screenPlayerDataRelay.value)
                self.filteredPlayerDataRelay.accept(self.screenPlayerDataRelay.value)
                
                players.forEach{ [unowned self] player in
                    if self.favoritePlayerIds.contains(player.id) && !favoritePlayers.contains(player){
                        self.favoritePlayers.append(player)
                    }
                }
                self.favoritedTeamRelay.accept(self.favoritePlayers)
                self.loaderSubject.onNext(false)
            })
    }
    
    func initializeSearchSubject(subject: ReplaySubject<String>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (value) in
                self.loaderSubject.onNext(true)
                self.searchValue.accept(value)
                self.filterablePlayerDataRelay
                    .map{ $0.filter({
                        if value.isEmpty{return true}
                        return $0.knownAs.lowercased().contains(value.lowercased())
                    })
                    }
                    .subscribe(onNext: { [unowned self] players in
                        self.filteredPlayerDataRelay.accept(players)
                        self.loaderSubject.onNext(false)
                    })
                    .dispose()
            })
    }
}
