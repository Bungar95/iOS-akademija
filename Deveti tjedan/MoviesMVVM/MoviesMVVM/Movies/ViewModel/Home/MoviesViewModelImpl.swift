//
//  MoviesViewModelImpl.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 14.07.2021..
//

import Foundation
import UIKit
class MoviesViewModelImpl: MoviesViewModel {
    
    weak var loaderDelegate: LoaderDelegate?
    weak var reloadTableDelegate: ReloadTableViewDelegate?
    weak var navigationDelegate: NavigationDelegate?
    
    var moviesList: [Movie] = []
    var movieCrew: [Crew] = []
    var currentMovieDirector: String = "N/A"
    var detailVC: MovieDetailsViewController?
    private let moviesRepository: MoviesRepository
    
    let userDefaults = UserDefaults.standard
    var watchedArray: [Int] = []
    var favoriteArray: [Int] = []
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
        self.watchedArray = UserPreference.watched.array
        self.favoriteArray = UserPreference.favorite.array
    }
    
    func loadMovies() {
        loaderDelegate?.showLoader()
        getMovies()
    }
    
    func loadGenres(movie: Movie) -> String {
        return getGenres(movie: movie)
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
    
    func refreshUserPreference() {
        loaderDelegate?.showLoader()
        self.watchedArray = UserPreference.watched.array
        self.favoriteArray = UserPreference.favorite.array
    }
    
    func prepareVC(movie: Movie, _ completionHandler: @escaping (UIViewController) -> Void){
        loaderDelegate?.showLoader()
        let vcBlock: (String) -> Void = { director in
            self.detailVC = MovieDetailsViewController(viewModel: MovieDetailsViewModelImpl(moviesRepository: MoviesRepositoryImpl(networkManager: NetworkManager()), movie: movie, director: director))
            guard let vc = self.detailVC else { return }
            completionHandler(vc)
        }
        getCredits(movieId: movie.id, vcBlock)
    }
}

private extension MoviesViewModelImpl {
    
    func getMovies() {
        moviesRepository.getMovies { (moviesResponse) -> (Void) in
            guard let movies = moviesResponse?.results else {
                return
            }
            self.moviesList = movies
            self.updateTableView()
        }
    }
    
    func getCredits(movieId: Int, _ completionHandler: @escaping (String) -> Void) {
        moviesRepository.getCredits(movieId: movieId) { (creditsResponse) -> (Void) in
            guard let crew = creditsResponse?.crew else {
                return
            }
            
            crew.forEach{(crewMember) in
                if(crewMember.job == "Director"){
                    self.currentMovieDirector = crewMember.name
                }
            }
            
            self.loaderDelegate?.hideLoader()
            completionHandler(self.currentMovieDirector)
        }
    }
    
    func getGenres(movie: Movie) -> String {
        return moviesRepository.getSingleMovieGenres(movieGenres: movie.genreIds)
    }
    
    func updateUserPreference(preference: UserPreference) {
        let savedArray = preference.array
        switch preference {
        case .favorite:
            self.favoriteArray = savedArray
        case .watched:
            self.watchedArray = savedArray
        }
    }
    
    func updateTableView() {
        loaderDelegate?.hideLoader()
        reloadTableDelegate?.reloadTableView()
    }
    
    func changeButtonIsSelected(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
