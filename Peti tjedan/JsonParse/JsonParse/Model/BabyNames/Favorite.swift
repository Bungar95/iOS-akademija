//
//  Favorite.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct Favorite: Codable {
    
    let id: Int
    let name: String
    let country: String
    let gender: String
    let isFavorite: Bool
    
}
