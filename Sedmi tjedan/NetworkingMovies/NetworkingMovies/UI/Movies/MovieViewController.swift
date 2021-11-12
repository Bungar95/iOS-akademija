//
//  ViewController.swift
//  NetworkingMovies
//
//  Created by Borna Ungar on 30.06.2021..
//

import UIKit

class MovieViewController: UIViewController {
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var movieList: [Movie] = []
    var crew: [Crew] = []
    var director: String = "N/A"
    let networkManager: NetworkManager
    let userDefaults = UserDefaults.standard
    private var favoriteArray: [Int] = []
    private var watchedArray: [Int] = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        
        setupUI()
        showLoader()
        setupTableView()
        getMovies()
    }
    
}

extension MovieViewController {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}

private extension MovieViewController {
    func getMovies() {
        networkManager.getMovieData(from: "https://api.themoviedb.org/3/movie/popular") { (movieResponse) in
            guard let movies = movieResponse?.results else {
                return
            }
            self.movieList = movies
            DispatchQueue.main.async { [unowned self] in
                hideLoader()
                self.tableView.reloadData()
            }
        }
    }
}

private extension MovieViewController {
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieTableViewCell")
    }
    
    func setupUI() {
        view.addSubview(progressView)
        view.addSubview(tableView)
        view.backgroundColor = UIColor.init(named: "backgroundGrey")
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        var movie = movieList[indexPath.section]
        let genres = getGenres(movieGenres: movie.genreIds)
        movieCell.configureCell(movieId: movie.id, movieTitle: movie.title, movieImageUrl: "https://image.tmdb.org/t/p/w185\(movie.posterPath)", movieGenresLabel: genres, movieRelease: movie.releaseDate)
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(named: "backgroundGrey")
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showLoader()
        tableView.deselectRow(at: indexPath, animated: true)
        getCredits(movieId: movieList[indexPath.section].id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            self.hideLoader()
            let secondVC = MovieDetailsViewController(movie: self.movieList[indexPath.section], director: self.director)
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
        
        }
}

extension MovieViewController {
    
    func getGenres(movieGenres: [Int]) -> String {
        
        var genres: [String] = []
        movieGenres.forEach{ (genre) in
            
            var currentGenre: String {
                switch genre {
                case 12: return "Adventure"
                case 14: return "Fantasy"
                case 16: return "Animation"
                case 18: return "Drama"
                case 27: return "Horror"
                case 28: return "Action"
                case 35: return "Comedy"
                case 36: return "History"
                case 37: return "Western"
                case 53: return "Thriller"
                case 80: return "Crime"
                case 99: return "Documentary"
                case 878: return "Science Fiction"
                case 9648: return "Mystery"
                case 10402: return "Music"
                case 10749: return "Romance"
                case 10751: return "Family"
                case 10752: return "War"
                case 10770: return "TV Movie"
                default: return "Unknown"
                }
            }

            genres.append(currentGenre)

        }
        
        return genres.joined(separator: ", ")
        
    }
    
}

extension MovieViewController {
    func getCredits(movieId: Int) {
        networkManager.getCreditsData(from: "https://api.themoviedb.org/3/movie/\(movieId)/credits") { (creditsResponse) in
            guard let crew = creditsResponse?.crew else {
                return
            }
            self.crew = crew
            
            crew.forEach{(crewMember) in
                if(crewMember.job == "Director"){
                    self.director = crewMember.name
                }
            }
        }
    }
}
