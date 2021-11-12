//
//  HomeViewController.swift
//  rx_example
//
//  Created by Zvonimir Medak on 04.03.2021..
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa


class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
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
        setupUI()
        setupTableView()
        initializeVM()
        viewModel.loadDataSubject.onNext(())
    }
}

private extension HomeViewController {
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

private extension HomeViewController {
    
    func initializeVM() {
        disposeBag.insert(viewModel.initializeViewModelObservables())
        initializeLoaderObservable(subject: viewModel.loaderSubject).disposed(by: disposeBag)
        initializeScreenDataObservable(subject: viewModel.screenDataRelay).disposed(by: disposeBag)
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
    
    func initializeScreenDataObservable(subject: BehaviorRelay<[SongList]>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (items) in
                if !items.isEmpty {
                    tableView.reloadData()
                }
            })
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.screenDataRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let songCell = tableView.dequeueReusableCell(withIdentifier: "songTableViewCell", for: indexPath) as? SongTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        let song = viewModel.screenDataRelay.value[indexPath.row]
        
        songCell.configureCell(songName: song.title, artistName: song.artist.name, artistImageUrl: song.artist.picture)
        return songCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HomeViewController {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}

