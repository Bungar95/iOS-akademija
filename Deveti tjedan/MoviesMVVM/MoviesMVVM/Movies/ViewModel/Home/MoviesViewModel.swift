//
//  MoviesViewModel.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 14.07.2021..
//

import Foundation
import UIKit
protocol MoviesViewModel: AnyObject {
    
    var loaderDelegate: LoaderDelegate? {get set}
    var reloadTableDelegate: ReloadTableViewDelegate? {get set}
    var navigationDelegate: NavigationDelegate? {set get}
    
    var moviesList: [Movie] {get set}
    var movieCrew: [Crew] {get set}
    var favoriteArray: [Int] {get set}
    var watchedArray: [Int] {get set}
    var detailVC: MovieDetailsViewController? {get set}
    
    func loadMovies()
    func loadGenres(movie: Movie) -> String
    
    func checkUserPreference(preference: UserPreference, movie: Movie) -> Bool
    func switchUserPreference(preference: UserPreference, sender: UIButton)
    func refreshUserPreference()
    
    func prepareVC(movie: Movie, _ completionHandler: @escaping (UIViewController) -> Void)
}
