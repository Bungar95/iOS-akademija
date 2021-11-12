//
//  MovieDetailsViewModelImpl.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 18.07.2021..
//

import Foundation
import UIKit
import RxSwift
class MovieDetailsViewModelImpl: MovieDetailsViewModel {
    
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)

    let userDefaults = UserDefaults.standard
    var watchedArray: [Int] = []
    var favoriteArray: [Int] = []
    var movieDetails: Movie?
    var director: String?
    
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository, movie: Movie, director: String) {
        self.moviesRepository = moviesRepository
        self.movieDetails = movie
        self.director = director
        self.watchedArray = UserPreference.watched.array
        self.favoriteArray = UserPreference.favorite.array
    }
    
    func checkUserPreference(preference: UserPreference, movie: Movie) -> Bool {
        switch preference {
        case .favorite:
            return favoriteArray.contains(movie.id)
        case .watched:
            return watchedArray.contains(movie.id)
        }
    }
    
    func switchUserPreference(preference: UserPreference, sender: UIButton) {
        
        var array: [Int] = []
        
        switch preference {
        case .favorite:
            array = favoriteArray
        case .watched:
            array = watchedArray
        }
        
        if(array.contains(sender.tag)){
            array.remove(at: array.firstIndex(of: sender.tag)!)
        }else{
            array.append(sender.tag)
        }
        userDefaults.setValue(array, forKey: preference.forKey)
        updateUserPreference(preference: preference)
        changeButtonIsSelected(sender: sender)
    }
    
    func setMovieDetails() {
    }
}

private extension MovieDetailsViewModelImpl {
    func updateUserPreference(preference: UserPreference) {
        let savedArray = preference.array
        switch preference {
        case .favorite:
            self.favoriteArray = savedArray
        case .watched:
            self.watchedArray = savedArray
        }
    }
    
    func changeButtonIsSelected(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}

