//
//  Links.swift
//  NetworkingMoviesCocoa
//
//  Created by Borna Ungar on 09.07.2021..
//

import Foundation

private let apiid = "?api_key=f7f4dcdbf711ae4096d446df5c212f79"
enum MovieRelatedUrl {
    case popularMovies
    case movieCredits(movieId: Int)
    
    var url: String {
        switch self {
        case .popularMovies:
            return "https://api.themoviedb.org/3/movie/popular\(apiid)"
        case .movieCredits(let movieId):
            return "https://api.themoviedb.org/3/movie/\(movieId)/credits\(apiid)"
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
