//
//  SongList.swift
//  MVVM_architecture_example
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation

struct SongList: Codable{
    let id: Int
    let title: String
    let artist: Artist
    let album: Album
}
