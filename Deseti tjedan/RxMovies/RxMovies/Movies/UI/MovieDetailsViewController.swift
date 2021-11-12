//
//  MovieDetailsViewController.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 17.07.2021..
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
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
        label.font = R.font.quicksandBold(size: 29)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let genresLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 21)
        label.textColor = .white
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = R.font.quicksandBold(size: 21)
        label.text = "Director: "
        return label
    }()
    
    let directorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = R.font.quicksandRegular(size: 21)
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
        label.font = R.font.quicksandRegular(size: 21)
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
    
    var viewModel: MovieDetailsViewModel
    
    init(viewModel:MovieDetailsViewModel){
        self.viewModel = viewModel
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
        
        guard let movieDetails = viewModel.movieDetails else { return }
        guard let director = viewModel.director else { return }
        let fStatus = viewModel.checkUserPreference(preference: .favorite, movie: movieDetails)
        let wStatus = viewModel.checkUserPreference(preference: .watched, movie: movieDetails)
        
        view.addSubviews(views: progressView, movieImageView, titleLabel, directorLabel, directorNameLabel, scrollView, movieFavoriteButton, movieWatchedButton)
        scrollView.addSubview(viewInsideScrollView)
        viewInsideScrollView.addSubview(overviewLabel)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = R.color.detailsBackground()
        
        if let url = URL(string: posterSize.w500(posterPath: movieDetails.posterPath).posterUrl) {
            movieImageView.kf.setImage(with: url)
        }
        titleLabel.text = movieDetails.title
        
        directorNameLabel.text = director
        
        overviewLabel.text = movieDetails.overview
        
        setButtons(id: movieDetails.id, favorite: fStatus, watched: wStatus)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        progressView.snp.makeConstraints{ (make) -> Void in
            make.centerX.centerY.equalToSuperview()
        }
        
        movieImageView.snp.makeConstraints{(make) in
            make.top.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2.5)
        }
        
        movieFavoriteButton.snp.makeConstraints{(make) in
            make.top.equalTo(movieImageView).offset(50)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        movieWatchedButton.snp.makeConstraints{(make) in
            make.bottom.equalTo(movieFavoriteButton)
            make.centerY.equalTo(movieFavoriteButton)
            make.trailing.equalTo(movieFavoriteButton.snp.leading).offset(-15)
        }
        
        titleLabel.snp.makeConstraints{(make) in
            make.top.equalTo(movieImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
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
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        viewInsideScrollView.snp.makeConstraints{(make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func setButtons(id: Int, favorite: Bool, watched: Bool){
        
        movieFavoriteButton.setImage(#imageLiteral(resourceName: "favoriteIconFalse"), for: .normal)
        movieFavoriteButton.setImage(#imageLiteral(resourceName: "favoriteIconTrue"), for: .selected)
        
        movieWatchedButton.setImage(#imageLiteral(resourceName: "watchedIconFalse"), for: .normal)
        movieWatchedButton.setImage(#imageLiteral(resourceName: "watchedIconTrue"), for: .selected)
        
        movieFavoriteButton.tag = id
        movieWatchedButton.tag = id
        
        movieFavoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        movieWatchedButton.addTarget(self, action: #selector(watchedButtonClicked), for: .touchUpInside)
        
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
    
    @objc
    private func favoriteButtonClicked(sender: UIButton) {
        
        viewModel.switchUserPreference(preference: .favorite, sender: sender)
        
    }
    
    @objc
    private func watchedButtonClicked(sender: UIButton) {
        
        viewModel.switchUserPreference(preference: .watched, sender: sender)
        
    }
}

extension MovieDetailsViewController {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}
