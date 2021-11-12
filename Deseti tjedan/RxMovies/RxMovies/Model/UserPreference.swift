//
//  UserPreference.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 15.07.2021..
//

import Foundation
enum UserPreference {
    case favorite
    case watched
    
    var array: [Int] {
        switch self {
        case .favorite:
            return UserDefaults.standard.array(forKey: "favoriteMovies") as? [Int] ?? []
        case .watched:
            return UserDefaults.standard.array(forKey: "watchedMovies") as? [Int] ?? []
        }
    }
    
    var forKey: String {
        switch self {
        case .favorite:
            return "favoriteMovies"
        case .watched:
            return "watchedMovies"
        }
    }
}
