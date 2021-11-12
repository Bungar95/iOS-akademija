//
//  Links.swift
//  NetworkingMoviesCocoa
//
//  Created by Borna Ungar on 09.07.2021..
//

import Foundation

// The Movies Database API Key
let api = "?api_key=f7f4dcdbf711ae4096d446df5c212f79"

enum RequestUrl {
    case popularMovies
    case movieCredits(movieId: Int)
    
    var url: String {
        switch self {
        case .popularMovies:
            return "https://api.themoviedb.org/3/movie/popular"+api
        case .movieCredits(let movieId):
            return "https://api.themoviedb.org/3/movie/\(movieId)/credits"+api
        }
    }
}

enum posterSize {
    case w500(posterPath: String)
    case w185(posterPath: String)
    
    var posterUrl: String {
        switch self {
        case .w500(let posterPath):
            return "https://image.tmdb.org/t/p/w500\(posterPath)"
        case .w185(let posterPath):
            return "https://image.tmdb.org/t/p/w185\(posterPath)"
        }
    }
}
