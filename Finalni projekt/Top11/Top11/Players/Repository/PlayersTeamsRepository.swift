//
//  PlayersTeamsRepository.swift
//  Top11
//
//  Created by Borna Ungar on 26.07.2021..
//

import Foundation
import RxSwift
class PlayersRepositoryImpl: PlayersRepository {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getPlayers() -> Observable<PlayersResponse> {
        let playersResponseObservable: Observable<PlayersResponse> = networkManager.getData(from: RequestUrl.getPlayers)
        return playersResponseObservable
    }
    
    func getTeams() -> Observable<TeamsResponse> {
        let teamsResponseObservable: Observable<TeamsResponse> = networkManager.getData(from: RequestUrl.getTeams)
        return teamsResponseObservable
    }
}

protocol PlayersRepository: AnyObject {
    func getPlayers() -> Observable<PlayersResponse>
    func getTeams() -> Observable<TeamsResponse>
}
