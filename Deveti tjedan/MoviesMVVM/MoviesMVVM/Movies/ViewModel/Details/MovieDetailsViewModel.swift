//
//  MovieDetailsViewModel.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 18.07.2021..
//

import Foundation
import UIKit
protocol MovieDetailsViewModel: AnyObject {
    
    var loaderDelegate: LoaderDelegate? {get set}
    
    var favoriteArray: [Int] {get set}
    var watchedArray: [Int] {get set}
    var movieDetails: Movie? {get set}
    var director: String? {get set}
    
    func checkUserPreference(preference: UserPreference, movie: Movie) -> Bool
    func switchUserPreference(preference: UserPreference, sender: UIButton)
}
