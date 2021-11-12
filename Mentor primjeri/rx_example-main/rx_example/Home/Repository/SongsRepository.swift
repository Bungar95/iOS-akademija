//
//  SongsRepository.swift
//  rx_example
//
//  Created by Zvonimir Medak on 04.03.2021..
//

import Foundation
import RxSwift

class SongsRepositoryImpl: SongsRepository {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getSongs() -> Observable<SongResponse> {
        let songResponseObservable: Observable<SongResponse> = networkManager.getData(url: "https://api.deezer.com/chart")
        return songResponseObservable
    }
}

protocol SongsRepository: class {
    func getSongs() -> Observable<SongResponse>
}
