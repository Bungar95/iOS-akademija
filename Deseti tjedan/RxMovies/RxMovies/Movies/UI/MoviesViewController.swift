//
//  ViewController.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 12.07.2021..
//

import UIKit
import Rswift
import SnapKit
import RxSwift
import RxCocoa

class MoviesViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let viewModel: MoviesViewModel
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.refreshUserPreference()
        initializeVM()
        initializeNextViewControllerObservable()
        viewModel.loadDataSubject.onNext(())
    }
}

private extension MoviesViewController {
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func registerCells() {
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: "moviesTableViewCell")
    }
    
    func setupUI() {
        view.addSubviews(views: progressView, tableView)
        view.bringSubviewToFront(progressView)
        view.backgroundColor = R.color.backgroundGrey()
        tableView.backgroundColor = R.color.backgroundGrey()
        setupConstraints()
    }
    
    func setupConstraints() {
        
        progressView.snp.makeConstraints{ (make) -> Void in
            make.centerX.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.bottom.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(15)
            make.trailing.equalTo(view).offset(-15)
        }
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = R.color.backgroundGrey()
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.screenMovieDataRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "moviesTableViewCell", for: indexPath) as? MoviesTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        let movie = viewModel.screenMovieDataRelay.value[indexPath.section]
        let movieGenres: String = viewModel.loadGenres(movie: movie)
        let fStatus = viewModel.checkUserPreference(preference: .favorite, movie: movie)
        let wStatus = viewModel.checkUserPreference(preference: .watched, movie: movie)
        
        movieCell.configureCell(movieId: movie.id, movieTitle: movie.title, movieImageUrl: posterSize.w185(posterPath: movie.posterPath), movieGenresLabel: movieGenres, movieRelease: movie.releaseDate, favoriteStatus: fStatus, watchedStatus: wStatus)
        
        movieCell.movieFavoriteButton.tag = movie.id
        movieCell.movieWatchedButton.tag = movie.id
        
        movieCell.movieFavoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        movieCell.movieWatchedButton.addTarget(self, action: #selector(watchedButtonClicked), for: .touchUpInside)
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.prepareVC(movie: self.viewModel.screenMovieDataRelay.value[indexPath.section])
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

private extension MoviesViewController {
    
    func initializeVM() {
        disposeBag.insert(viewModel.initializeViewModelObservables())
        initializeLoaderObservable(subject: viewModel.loaderSubject).disposed(by: disposeBag)
        initializeScreenDataObservable(subject: viewModel.screenMovieDataRelay).disposed(by: disposeBag)
        initializeDirectorDataObservable(subject: viewModel.screenDirectorDataRelay).disposed(by: disposeBag)
    }
    
    func initializeNextViewControllerObservable() {
        initializeNextVCObservable(subject: viewModel.loadNextVCSubject).disposed(by: disposeBag)
    }
    
    func initializeNextVCObservable(subject: PublishSubject<MovieDetailsViewController>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [weak self] vc in
                self?.viewModel.screenDirectorDataRelay.onCompleted()
                self?.pushNavigation(viewController: vc)
            })
    }
    
    func initializeDirectorDataObservable(subject: PublishSubject<String>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (director) in
                self.viewModel.changeDirector(director: director)
            })
    }
    
    func initializeLoaderObservable(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (status) in
                if status {
                    showLoader()
                } else {
                    hideLoader()
                }
            })
    }
    
    func initializeScreenDataObservable(subject: BehaviorRelay<[Movie]>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (movies) in
                if !movies.isEmpty {
                    tableView.reloadData()
                }
            })
    }
}

extension MoviesViewController {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}

extension MoviesViewController {
    
    func pushNavigation(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
