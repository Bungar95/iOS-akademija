//
//  SongsRepository.swift
//  MVVM_architecture_example
//
//  Created by Zvonimir Medak on 04.03.2021..
//

import Foundation

class SongsRepositoryImpl: SongsRepository {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getSongs(_ completed: @escaping (SongResponse?) -> (Void)) {
        networkManager.getData(from: "https://api.deezer.com/chart", completed)
    }
}

protocol SongsRepository: class {
    func getSongs(_ completed: @escaping (SongResponse?) -> (Void))
}
