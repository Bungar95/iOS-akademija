//
//  HomeViewModel.swift
//  MVVM_architecture_example
//
//  Created by Zvonimir Medak on 05.03.2021..
//

import Foundation

protocol HomeViewModel: class {
    
    var loaderDelegate: LoaderDelegate? {get set}
    var reloadTableDelegate: ReloadTableVIewDelegate? {get set}
    var songList: [SongList] {get set}
    
    func loadSongs()
}
