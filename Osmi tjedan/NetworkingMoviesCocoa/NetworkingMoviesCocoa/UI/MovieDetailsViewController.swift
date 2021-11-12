//
//  MovieDetailsViewController.swift
//  NetworkingMoviesCocoa
//
//  Created by Borna Ungar on 07.07.2021..
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    var movieDetails: Movie
    var director: String
    let userDefaults = UserDefaults.standard
    
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
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Bold", size: 29)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let genresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Regular", size: 21)
        label.textColor = .white
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.init(name: "Quicksand-Bold", size: 21)
        label.text = "Director: "
        return label
    }()
    
    let directorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.init(name: "Quicksand-Regular", size: 21)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let sView = UIScrollView()
        return sView
    }()
    
    let viewInsideScrollView: UIView = {
        let insideView = UIView()
        return insideView
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Regular", size: 21)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let movieWatchedButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    let movieFavoriteButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    init(movie: Movie, director: String){
        self.director = director
        self.movieDetails = movie
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
        scrollView.addSubview(viewInsideScrollView)
        viewInsideScrollView.addSubview(overviewLabel)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = UIColor.init(named: "detailsBackground")
        
        if let url = URL(string: posterSize.w500(posterPath: movieDetails.posterPath).posterUrl) {
            movieImageView.kf.setImage(with: url)
        }
        titleLabel.text = movieDetails.title
        
        directorNameLabel.text = director
        
        overviewLabel.text = movieDetails.overview
        
        setButtons(id: movieDetails.id)
        
        setupConstraints()
    }
    
    func setButtons(id: Int){
        
        movieFavoriteButton.setImage(#imageLiteral(resourceName: "favoriteIconFalse"), for: .normal)
        movieFavoriteButton.setImage(#imageLiteral(resourceName: "favoriteIconTrue"), for: .selected)
        movieFavoriteButton.tag = id
        
        movieWatchedButton.setImage(#imageLiteral(resourceName: "watchedIconFalse"), for: .normal)
        movieWatchedButton.setImage(#imageLiteral(resourceName: "watchedIconTrue"), for: .selected)
        movieWatchedButton.tag = id

        
        if let favoriteArray: [Int] = userDefaults.array(forKey: "favoriteMovies") as? [Int], favoriteArray.contains(id) {
            movieFavoriteButton.isSelected = true
        }
        movieFavoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        
        if let watchedArray: [Int] = userDefaults.array(forKey: "watchedMovies") as? [Int], watchedArray.contains(id) {
            movieWatchedButton.isSelected = true
        }
        movieWatchedButton.addTarget(self, action: #selector(watchedButtonClicked), for: .touchUpInside)


    }
    
    @objc
    private func favoriteButtonClicked(sender: UIButton) {
        
        userPreferenceSwitch(sender: sender, preferenceArray: .favorite)
                
    }
    
    @objc
    private func watchedButtonClicked(sender: UIButton) {
        
        userPreferenceSwitch(sender: sender, preferenceArray: .watched)
                
    }
    
    func userPreferenceSwitch(sender: UIButton, preferenceArray: Preference){
        var prefArray: [Int]
        if var array: [Int] = userDefaults.array(forKey: preferenceArray.forKey) as? [Int] {
            
            if !array.contains(sender.tag) {
                array.append(sender.tag)
            } else {
                array.remove(at: array.firstIndex(of: sender.tag)!)
            }
            userDefaults.setValue(array, forKey: preferenceArray.forKey)
            
        } else {
            switch preferenceArray {
            case .watched:
                prefArray = Preference.watched.array
            case .favorite:
                prefArray = Preference.favorite.array
            }
            prefArray.append(sender.tag)
            userDefaults.setValue(prefArray, forKey: preferenceArray.forKey)
        }
        sender.isSelected = !sender.isSelected
    }
    
    func setupConstraints(){
        movieImageView.snp.makeConstraints{(make) in
            make.top.leading.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(UIScreen.main.bounds.height/2.5)
        }
        
        movieFavoriteButton.snp.makeConstraints{(make) in
            make.top.equalTo(movieImageView).offset(20)
            make.trailing.equalTo(view).offset(-15)
        }
        
        movieWatchedButton.snp.makeConstraints{(make) in
            make.bottom.equalTo(movieFavoriteButton)
            make.centerY.equalTo(movieFavoriteButton)
            make.trailing.equalTo(movieFavoriteButton.snp.leading).offset(-15)
        }
        
        titleLabel.snp.makeConstraints{(make) in
            make.top.equalTo(movieImageView.snp.bottom).offset(15)
            make.leading.equalTo(view).offset(15)
            make.trailing.equalTo(view).offset(-15)
        }
        
        directorLabel.snp.makeConstraints{(make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.leading.equalTo(titleLabel)
        }
        
        directorNameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(directorLabel)
            make.leading.equalTo(directorLabel.snp.trailing)
        }
        
        scrollView.snp.makeConstraints{(make) in
            make.top.equalTo(directorLabel.snp.bottom).offset(7)
            make.leading.bottom.trailing.equalTo(view)
        }
        
        viewInsideScrollView.snp.makeConstraints{(make) in
            make.top.bottom.equalTo(scrollView)
            make.leading.equalTo(view).offset(15)
            make.trailing.equalTo(view).offset(-15)
            make.centerX.equalTo(scrollView)
        }
        
        overviewLabel.snp.makeConstraints{(make) in
            make.edges.equalTo(viewInsideScrollView)
            make.centerX.equalTo(viewInsideScrollView)
        }
    }
}
