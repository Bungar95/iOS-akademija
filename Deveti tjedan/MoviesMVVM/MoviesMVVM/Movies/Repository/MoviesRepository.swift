//
//  MoviesRepository.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 14.07.2021..
//

import Foundation
class MoviesRepositoryImpl: MoviesRepository {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMovies(_ completed: @escaping (MovieResponse?) -> (Void)) {
        networkManager.getData(from: RequestUrl.popularMovies, completed)
    }
    
    func getCredits(movieId: Int, _ completed: @escaping (CreditsResponse?) -> (Void)) {
        networkManager.getData(from: RequestUrl.movieCredits(movieId: movieId), completed)
    }
    
    func getSingleMovieGenres(movieGenres: [Int]) -> String {
        var genres: [String] = []
        movieGenres.forEach{ (genre) in
            
            var currentGenre: String {
                switch genre {
                case 12: return "Adventure"
                case 14: return "Fantasy"
                case 16: return "Animation"
                case 18: return "Drama"
                case 27: return "Horror"
                case 28: return "Action"
                case 35: return "Comedy"
                case 36: return "History"
                case 37: return "Western"
                case 53: return "Thriller"
                case 80: return "Crime"
                case 99: return "Documentary"
                case 878: return "Science Fiction"
                case 9648: return "Mystery"
                case 10402: return "Music"
                case 10749: return "Romance"
                case 10751: return "Family"
                case 10752: return "War"
                case 10770: return "TV Movie"
                default: return "Unknown"
                }
            }            
            genres.append(currentGenre)
        }
        return genres.joined(separator: ", ")
    }
}

protocol MoviesRepository: AnyObject {
    func getMovies(_ completed: @escaping (MovieResponse?) -> (Void))
    func getCredits(movieId: Int, _ completed: @escaping (CreditsResponse?) -> (Void))
    func getSingleMovieGenres(movieGenres: [Int]) -> String
}
