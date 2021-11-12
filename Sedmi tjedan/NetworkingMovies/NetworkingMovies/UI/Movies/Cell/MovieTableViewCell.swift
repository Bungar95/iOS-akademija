//
//  MovieTableViewCell.swift
//  NetworkingMovies
//
//  Created by Borna Ungar on 01.07.2021..
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
        
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Bold", size: 17)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 155, height: 155)
        gradientLayer.colors = [
            UIColor.init(named: "Gradient0")?.cgColor ?? UIColor.clear.cgColor,
            UIColor.init(named: "Gradient90")?.cgColor ?? UIColor.init(white: 0, alpha: 0.9)
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        iv.layer.insertSublayer(gradientLayer, at: 1)
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let movieGenreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Regular", size: 15)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieReleasedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Medium", size: 21)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    let userDefaults = UserDefaults.standard
    private var favoriteArray: [Int]
    private var watchedArray: [Int]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.favoriteArray = userDefaults.array(forKey: "favoriteMovies") as? [Int] ?? []
        self.watchedArray = userDefaults.array(forKey: "watchedMovies") as? [Int] ?? []
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(movieId: Int, movieTitle: String, movieImageUrl: String, movieGenresLabel: String, movieRelease: String?) {
        movieNameLabel.text = movieTitle
        if let url = URL(string: movieImageUrl) {
            movieImageView.downloaded(from: url)
        }
        movieGenreLabel.text = movieGenresLabel
        if let release = movieRelease {
            movieReleasedLabel.text = String(release.prefix(4))
        }
        
        addFavoriteButton(id: movieId)
        addWatchedButton(id: movieId)
        
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
}

private extension MovieTableViewCell {
    
    func setupUI() {
        contentView.backgroundColor = UIColor.init(named: "movieGrey")
        
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieGenreLabel)
        contentView.addSubview(movieWatchedButton)
        contentView.addSubview(movieFavoriteButton)
        
        movieImageView.addSubview(movieReleasedLabel)
        
        contentView.layer.cornerRadius = 20
        movieImageView.layer.cornerRadius = 20
        self.backgroundColor = UIColor.init(named: "backgroundGrey")
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
                        
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 155),
            movieImageView.heightAnchor.constraint(equalToConstant: 155),
            
            movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            movieGenreLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 2),
            movieGenreLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            movieGenreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            movieReleasedLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -4),
            movieReleasedLabel.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            
            movieWatchedButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            movieWatchedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -65),
            
            movieFavoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            movieFavoriteButton.leadingAnchor.constraint(equalTo: movieWatchedButton.trailingAnchor, constant: 15),
            movieFavoriteButton.centerYAnchor.constraint(equalTo: movieWatchedButton.centerYAnchor)
            
        ])
    }
    
}

