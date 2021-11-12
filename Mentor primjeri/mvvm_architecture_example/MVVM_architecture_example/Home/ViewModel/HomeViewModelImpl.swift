//
//  HomeViewModel.swift
//  MVVM_architecture_example
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation

class HomeViewModelImpl: HomeViewModel {
    
    weak var loaderDelegate: LoaderDelegate?
    weak var reloadTableDelegate: ReloadTableVIewDelegate?
    
    var songList: [SongList] = []
    private let songsRepository: SongsRepository
    
    init(songsRepository: SongsRepository) {
        self.songsRepository = songsRepository
    }
    
    func loadSongs() {
        loaderDelegate?.showLoader()
        getSongs()
    }
    
}

private extension HomeViewModelImpl {
    func getSongs() {
        songsRepository.getSongs { (songResponse) -> (Void) in
            guard let songs = songResponse?.tracks?.data else {
                return
            }
            self.songList = songs
            self.updateTableView()
        }
    }
    
    func updateTableView() {
        loaderDelegate?.hideLoader()
        reloadTableDelegate?.reloadTableView()
    }
}

