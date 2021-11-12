//
//  MoviesViewModelImpl.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 14.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class MoviesViewModelImpl: MoviesViewModel {
    
    var screenMovieDataRelay = BehaviorRelay<[Movie]>.init(value: [])
    var screenCreditsDataRelay = BehaviorRelay<[Crew]>.init(value: [])
    
    var screenSingleMovieDataRelay = PublishSubject<Movie>.init()
    var screenDirectorDataRelay = PublishSubject<String>.init()
    
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    var loadNextVCSubject = PublishSubject<MovieDetailsViewController>.init()
    //    weak var navigationDelegate: NavigationDelegate?
    
    private let moviesRepository: MoviesRepository
    
    var currentMovieDirector: String = "N/A"
    var currentSingleMovie: Movie?
    let userDefaults = UserDefaults.standard
    var watchedArray: [Int] = []
    var favoriteArray: [Int] = []
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
        self.watchedArray = UserPreference.watched.array
        self.favoriteArray = UserPreference.favorite.array
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadMoviesSubject(subject: loadDataSubject))
        return disposables
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
        self.loaderSubject.onNext(true)
        self.watchedArray = UserPreference.watched.array
        self.favoriteArray = UserPreference.favorite.array
    }
    
    func changeDirector(director: String) {
        currentMovieDirector = director
    }
    
    func prepareVC(movie: Movie){
        screenSingleMovieDataRelay.onNext(movie)
        getCreditsAndDirector(movie: movie, subject: loadDataSubject)
        getDetailsVC(movie: movie, subject: screenDirectorDataRelay)
    }
}

private extension MoviesViewModelImpl {
    
    func getDetailsVC(movie: Movie, subject: PublishSubject<String>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (_) in
                let detailsVC = MovieDetailsViewController(viewModel: MovieDetailsViewModelImpl(moviesRepository: moviesRepository, movie: movie, director: currentMovieDirector))
                self.loadNextVCSubject.onNext(detailsVC)
            })
    }
    
    func initializeLoadMoviesSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<MovieResponse> in
                self.loaderSubject.onNext(true)
                return self.moviesRepository.getMovies()
            }
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (movieResponse) in
                let movies = movieResponse.results
                self.screenMovieDataRelay.accept(movies)
                self.loaderSubject.onNext(false)
            })
    }
    
    func getCreditsAndDirector(movie: Movie, subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<CreditsResponse> in
                self.loaderSubject.onNext(true)
                return self.moviesRepository.getCredits(movieId: movie.id)
            }
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (creditsResponse) in
                guard let crew = creditsResponse.crew else { return }
                self.screenCreditsDataRelay.accept(crew)
                crew.forEach{(crewMember) in
                    if(crewMember.job == "Director"){
                        self.screenDirectorDataRelay.onNext(crewMember.name)
                    }
                }
                self.loaderSubject.onNext(false)
            })
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
    
    func changeButtonIsSelected(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
