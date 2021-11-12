//
//  MoviesViewModel.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 14.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
protocol MoviesViewModel: AnyObject {
    
    var screenMovieDataRelay: BehaviorRelay<[Movie]> {get}
    var screenCreditsDataRelay: BehaviorRelay<[Crew]> {get}
    
    var screenDirectorDataRelay: PublishSubject<String> {get}
    var screenSingleMovieDataRelay: PublishSubject<Movie> {get}
 
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadDataSubject: ReplaySubject<()> {get}
    var loadNextVCSubject: PublishSubject<(MovieDetailsViewController)> {get}

    var favoriteArray: [Int] {get set}
    var watchedArray: [Int] {get set}
    
    func initializeViewModelObservables() -> [Disposable]
    
    func loadGenres(movie: Movie) -> String
    func changeDirector(director: String)
    
    func checkUserPreference(preference: UserPreference, movie: Movie) -> Bool
    func switchUserPreference(preference: UserPreference, sender: UIButton)
    func refreshUserPreference()
    
    func prepareVC(movie: Movie)
}
