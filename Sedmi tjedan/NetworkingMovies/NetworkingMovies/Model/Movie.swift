//
//  Movies.swift
//  NetworkingMovies
//
//  Created by Borna Ungar on 30.06.2021..
//

import Foundation
struct Movie: Codable {
    
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String?
    let overview: String?
    let genreIds: [Int]
    
}
