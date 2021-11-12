//
//  TableViewController.swift
//  MVVM_architecture_example
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation
import UIKit
import SnapKit


class HomeViewController: UIViewController {
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
        setupTableView()
    }
}

private extension HomeViewController {
    
    func setupViewModel() {
        viewModel.loaderDelegate = self
        viewModel.reloadTableDelegate = self
        viewModel.loadSongs()
    }
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: "songTableViewCell")
    }
    
    func setupUI() {
        view.addSubviews(views: progressView, tableView)
        view.bringSubviewToFront(progressView)
        setupConstraints()
    }
    
    func setupConstraints() {
        progressView.snp.makeConstraints({ (maker) in
            maker.centerX.centerY.equalToSuperview()
        })
        
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let songCell = tableView.dequeueReusableCell(withIdentifier: "songTableViewCell", for: indexPath) as? SongTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        let song = viewModel.songList[indexPath.row]
        
        songCell.configureCell(songName: song.title, artistName: song.artist.name, artistImageUrl: song.artist.picture)
        return songCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HomeViewController: ReloadTableVIewDelegate {
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension HomeViewController: LoaderDelegate {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}
