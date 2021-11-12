//
//  SongList.swift
//  rx_example
//
//  Created by Zvonimir Medak on 04.03.2021..
//

import Foundation

struct SongList: Codable{
    let id: Int
    let title: String
    let artist: Artist
    let album: Album
}
