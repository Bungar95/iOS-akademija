//
//  MovieTableViewCell.swift
//  NetworkingMoviesCocoa
//
//  Created by Borna Ungar on 07.07.2021..
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class MovieTableViewCell: UITableViewCell {
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Bold", size: 17)
        label.textColor = .white
        label.numberOfLines = 2
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
        return iv
    }()
    
    let movieGenreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Regular", size: 15)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let movieReleasedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Quicksand-Medium", size: 21)
        label.textColor = .white
        return label
    }()
    
    let movieWatchedButton = UIButton()
    let movieFavoriteButton = UIButton()
    
    let userDefaults = UserDefaults.standard
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(movieId: Int, movieTitle: String, movieImageUrl: posterSize, movieGenresLabel: String, movieRelease: String?) {
        movieNameLabel.text = movieTitle
        if let url = URL(string: movieImageUrl.posterUrl) {
            movieImageView.kf.setImage(with: url)
        }
        movieGenreLabel.text = movieGenresLabel
        if let release = movieRelease {
            movieReleasedLabel.text = String(release.prefix(4))
        }
        
        setButtons(id: movieId)
        
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
        
        movieImageView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(155)
            make.top.leading.equalTo(contentView)
        }
        
        movieNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(movieImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView).offset(-15)
        }
        
        movieGenreLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(movieNameLabel)
            make.trailing.equalTo(contentView).offset(-15)
        }
        
        movieReleasedLabel.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(movieImageView).offset(-5)
            make.centerX.equalTo(movieImageView)
        }
        
        movieFavoriteButton.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(contentView).offset(-8)
            make.trailing.equalTo(contentView).offset(-15)
        }
        movieWatchedButton.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(movieFavoriteButton)
            make.trailing.equalTo(movieFavoriteButton.snp.leading).offset(-10)
            make.centerY.equalTo(movieFavoriteButton)
        }
        
        
    }
}
