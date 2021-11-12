//
//  MovieDetailsViewController.swift
//  NetworkingMovies
//
//  Created by Borna Ungar on 03.07.2021..
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieDetails: Movie
    var director: String
    let userDefaults = UserDefaults.standard
    private var favoriteArray: [Int] = []
    private var watchedArray: [Int] = []
    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4)
        gradientLayer.colors = [
            UIColor.init(named: "Gradient0")?.cgColor ?? UIColor.clear.cgColor,
            UIColor.init(named: "Gradient90")?.cgColor ?? UIColor.init(white: 0, alpha: 0.9)
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        iv.layer.insertSublayer(gradientLayer, at: 1)
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Quicksand-Bold", size: 29)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Quicksand-Regular", size: 21)
        label.textColor = .white
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.init(name: "Quicksand-Bold", size: 21)
        label.text = "Director: "
        return label
    }()
    
    let directorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.init(name: "Quicksand-Regular", size: 21)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let sView = UIScrollView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Quicksand-Regular", size: 21)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let movieWatchedButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let movieFavoriteButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init(movie: Movie, director: String){
        self.director = director
        self.movieDetails = movie
        self.favoriteArray = userDefaults.array(forKey: "favoriteMovies") as? [Int] ?? []
        self.watchedArray = userDefaults.array(forKey: "watchedMovies") as? [Int] ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.addSubview(movieImageView)
        view.addSubview(titleLabel)
        view.addSubview(directorLabel)
        view.addSubview(directorNameLabel)
        view.addSubview(scrollView)
        view.addSubview(movieFavoriteButton)
        view.addSubview(movieWatchedButton)
        scrollView.addSubview(overviewLabel)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = UIColor.init(named: "detailsBackground")
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails.posterPath)") {
            movieImageView.downloaded(from: url)
        }
        titleLabel.text = movieDetails.title
        
        directorNameLabel.text = director
        
        overviewLabel.text = movieDetails.overview
        
        addFavoriteButton(id: movieDetails.id)
        addWatchedButton(id: movieDetails.id)
        
        setupConstraints()
    }
    
    func addFavoriteButton(id: Int){
        if let favoriteArray: [Int] = userDefaults.array(forKey: "favoriteMovies") as? [Int], favoriteArray.contains(id) {
            movieFavoriteButton.setImage(#imageLiteral(resourceName: "favoriteIconTrue"), for: .normal)
                } else {
                    movieFavoriteButton.setImage(#imageLiteral(resourceName: "favoriteIconFalse"), for: .normal)
                }
        movieFavoriteButton.tag = id
        movieFavoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    }
    
    func addWatchedButton(id: Int){
        if let watchedArray: [Int] = userDefaults.array(forKey: "watchedMovies") as? [Int], watchedArray.contains(id) {
            movieWatchedButton.setImage(#imageLiteral(resourceName: "watchedIconTrue"), for: .normal)
                } else {
                    movieWatchedButton.setImage(#imageLiteral(resourceName: "watchedIconFalse"), for: .normal)
                }
        movieWatchedButton.tag = id
        movieWatchedButton.addTarget(self, action: #selector(watchedButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func favoriteButtonClicked(sender: UIButton) {
            
            var imageName: String = ""
            
            if var favArray: [Int] = userDefaults.array(forKey: "favoriteMovies") as? [Int] {
                
                if !favArray.contains(sender.tag) {
                    favArray.append(sender.tag)
                    imageName = "favoriteIconTrue"
                } else {
                    favArray.remove(at: favArray.firstIndex(of: sender.tag)!)
                    imageName = "favoriteIconFalse"
                }
                userDefaults.setValue(favArray, forKey: "favoriteMovies")
                
            } else {
                favoriteArray.append(sender.tag)
                userDefaults.setValue(favoriteArray, forKey: "favoriteMovies")
                
                imageName = "favoriteIconTrue"
            }
            print("clicked")
            movieFavoriteButton.setImage(UIImage(named: imageName), for: .normal)
            
        }
    
    @objc
    private func watchedButtonClicked(sender: UIButton) {
            
            var imageName: String = ""
            
            if var watchArray: [Int] = userDefaults.array(forKey: "watchedMovies") as? [Int] {
                
                if !watchArray.contains(sender.tag) {
                    watchArray.append(sender.tag)
                    imageName = "watchedIconTrue"
                } else {
                    watchArray.remove(at: watchArray.firstIndex(of: sender.tag)!)
                    imageName = "watchedIconFalse"
                }
                userDefaults.setValue(watchArray, forKey: "watchedMovies")
                
            } else {
                watchedArray.append(sender.tag)
                userDefaults.setValue(watchedArray, forKey: "watchedMovies")
                
                imageName = "watchedIconTrue"
            }
            
            movieWatchedButton.setImage(UIImage(named: imageName), for: .normal)
            
        }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            movieImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2.5),
            
            movieFavoriteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            movieFavoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            movieWatchedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            movieWatchedButton.trailingAnchor.constraint(equalTo: movieFavoriteButton.leadingAnchor, constant: -15),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            directorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            directorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            directorNameLabel.topAnchor.constraint(equalTo: directorLabel.topAnchor),
            directorNameLabel.leadingAnchor.constraint(equalTo: directorLabel.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 7),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            overviewLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            overviewLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
    
}
