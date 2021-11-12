//
//  MoviesTableViewCell.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 14.07.2021..
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import Rswift

class MoviesTableViewCell: UITableViewCell {
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandBold(size: 17)
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
        label.font = R.font.quicksandRegular(size: 15)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let movieReleasedLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandMedium(size: 21)
        label.textColor = .white
        return label
    }()
    
    let movieWatchedButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    let movieFavoriteButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    let spacer : UIView = {
        let spacer = UIView()
        spacer.backgroundColor = .red
        return spacer
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(movieId: Int, movieTitle: String, movieImageUrl: posterSize, movieGenresLabel: String, movieRelease: String?, favoriteStatus: Bool, watchedStatus: Bool) {
        movieNameLabel.text = movieTitle
        if let url = URL(string: movieImageUrl.posterUrl) {
            movieImageView.kf.setImage(with: url)
        }
        movieGenreLabel.text = movieGenresLabel
        if let release = movieRelease {
            movieReleasedLabel.text = String(release.prefix(4))
        }
        
        setButtons(id: movieId, favorite: favoriteStatus, watched: watchedStatus)
    }
    
    func setButtons(id: Int, favorite: Bool, watched: Bool){
        
        movieFavoriteButton.setImage(#imageLiteral(resourceName: "favoriteIconFalse"), for: .normal)
        movieFavoriteButton.setImage(#imageLiteral(resourceName: "favoriteIconTrue"), for: .selected)
        
        movieWatchedButton.setImage(#imageLiteral(resourceName: "watchedIconFalse"), for: .normal)
        movieWatchedButton.setImage(#imageLiteral(resourceName: "watchedIconTrue"), for: .selected)
        
        if(favorite){
            movieFavoriteButton.isSelected = true
        }else{
            movieFavoriteButton.isSelected = false
        }
        
        if(watched){
            movieWatchedButton.isSelected = true
        }else{
            movieWatchedButton.isSelected = false
        }
    }
}

private extension MoviesTableViewCell {
    
    func setupUI() {
        contentView.backgroundColor = R.color.movieGrey()
        self.backgroundColor = R.color.backgroundGrey()
        self.selectionStyle = .none
        
        contentView.addSubviews(views: movieNameLabel, movieImageView, movieGenreLabel, movieWatchedButton, movieFavoriteButton)
        
        movieImageView.addSubview(movieReleasedLabel)
        
        contentView.layer.cornerRadius = 20
        movieImageView.layer.cornerRadius = 20
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        movieImageView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(155)
            make.top.leading.equalToSuperview()
        }
        
        movieNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(movieImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        movieGenreLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(movieNameLabel)
            make.trailing.equalTo(movieNameLabel)
        }
        
        movieReleasedLabel.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(movieImageView).offset(-5)
            make.centerX.equalTo(movieImageView)
        }
        
        movieFavoriteButton.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview().offset(-15)
        }
        movieWatchedButton.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(movieFavoriteButton)
            make.trailing.equalTo(movieFavoriteButton.snp.leading).offset(-10)
            make.centerY.equalTo(movieFavoriteButton)
        }
    }
}
