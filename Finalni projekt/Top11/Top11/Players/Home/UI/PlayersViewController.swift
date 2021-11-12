//
//  PlayersViewController.swift
//  Top11
//
//  Created by Borna Ungar on 27.07.2021..
//

import Foundation
import UIKit
import Rswift
import SnapKit
import RxSwift
import RxCocoa
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

class PlayersViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .lightGray
        return tv
    }()
    
    let topContainerView: UIView = {
        let sv = UIView()
        return sv
    }()
    
    let currentTeamTopView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    let favoriteTopView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    let acceptTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("Proceed with this team (0)", for: .normal)
        button.titleLabel?.font = R.font.quicksandRegular(size: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    let previousTeamsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous selected team", for: .normal)
        button.titleLabel?.font = R.font.quicksandRegular(size: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemTeal
        return button
    }()
    
    let sortNameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sort by name", for: .normal)
        button.titleLabel?.font = R.font.quicksandRegular(size: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray2
        return button
    }()
    
    let sortPositionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Group by position", for: .normal)
        button.titleLabel?.font = R.font.quicksandRegular(size: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray3
        return button
    }()
    
    let buttonsView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 5
        return sv
    }()
    
    let searchTextField: MDCFilledTextField = {
        let textField = MDCFilledTextField()
        textField.label.text = "Search players"
        textField.placeholder = "Start typing..."
        textField.sizeToFit()
        textField.setUnderlineColor(.black, for: .normal)
        textField.setUnderlineColor(.blue, for: .editing)
        textField.returnKeyType = UIReturnKeyType.done
        textField.enablesReturnKeyAutomatically = false
        textField.snapshotView(afterScreenUpdates: true)
        return textField
    }()
    
    let allFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("All", for: .normal)
        button.titleLabel?.font = R.font.quicksandRegular(size: 14)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .selected)
        button.backgroundColor = .lightGray
        button.isSelected = true
        button.layer.cornerRadius = 0
        return button
    }()
    
    let favoriteFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favorites (0)", for: .normal)
        button.titleLabel?.font = R.font.quicksandRegular(size: 14)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .selected)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 0
        return button
    }()
    
    let currentTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("Current Team", for: .normal)
        button.titleLabel?.font = R.font.quicksandRegular(size: 14)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .selected)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 0
        return button
    }()
    
    let infoButton: UIButton = {
        let infoButton = UIButton(type: .infoLight)
        return infoButton
    }()
    
    let viewModel: PlayersViewModel
    
    init(viewModel: PlayersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupUI()
        setupTableView()
        initializeVM()
        viewModel.loadTeamsSubject.onNext(())
    }
    
}
private extension PlayersViewController {
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableView.addGestureRecognizer(longPress)
        
        searchTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(650), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.searchValueSubject.onNext(text)
                tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
    
    func registerCells() {
        tableView.register(PlayersTableViewCell.self, forCellReuseIdentifier: "playersTableViewCell")
    }
    
    func setupUI() {
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: infoButton)
        view.addSubviews(views: progressView, tableView, topContainerView)
        topContainerView.addSubviews(views: searchTextField, buttonsView, currentTeamTopView, favoriteTopView)
        
        buttonsView.addArrangedSubview(allFilterButton)
        buttonsView.addArrangedSubview(favoriteFilterButton)
        buttonsView.addArrangedSubview(currentTeamButton)
        
        favoriteTopView.addArrangedSubview(sortNameButton)
        favoriteTopView.addArrangedSubview(sortPositionButton)
        favoriteTopView.isHidden = true
        
        currentTeamTopView.addArrangedSubview(acceptTeamButton)
        currentTeamTopView.addArrangedSubview(previousTeamsButton)
        currentTeamTopView.isHidden = true
        
        view.bringSubviewToFront(progressView)
        view.backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        
        topContainerView.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        currentTeamTopView.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        favoriteTopView.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        searchTextField.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        buttonsView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(searchTextField.snp.bottom).offset(1)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        progressView.snp.makeConstraints{ (make) -> Void in
            make.centerX.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(topContainerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func infoButtonTapped() {
        showAlert(alertText: "Instructions", alertMessage: "Tap: Player info \nLong press: Add player to team\n\n App is called Top11 but you can make a team of 2-11 players.")
    }
}

extension PlayersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredPlayerDataRelay.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let playerCell = tableView.dequeueReusableCell(withIdentifier: "playersTableViewCell", for: indexPath) as? PlayersTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let player = viewModel.filteredPlayerDataRelay.value[indexPath.row]
        let fStatus = viewModel.checkFavoriteStatus(playerId: player.id)
        
        playerCell.configureCell(playerId: player.id, playerName: player.knownAs, playerPosition: player.position, playerClub: checkTeamName(id: player.clubTeamId), favoriteStatus: fStatus)
        
        playerCell.favoriteButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.switchFavoriteStatus(player: player)
                playerCell.favoriteButton.isSelected = !playerCell.favoriteButton.isSelected
                if(favoriteFilterButton.isSelected){
                    self.viewModel.filteredPlayerDataRelay.accept(viewModel.favoritedTeamRelay.value)
                    tableView.reloadData()
                }
            }).disposed(by: playerCell.cellDisposeBag)
        
        return playerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(viewModel.filteredPlayerDataRelay.value.isEmpty){
            self.viewModel.singlePlayerRelay.accept(viewModel.screenPlayerDataRelay.value[indexPath.row])
        }else{
            self.viewModel.singlePlayerRelay.accept(viewModel.filteredPlayerDataRelay.value[indexPath.row])
        }
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let player: Player
                if(viewModel.filteredPlayerDataRelay.value.isEmpty){
                    player = viewModel.screenPlayerDataRelay.value[indexPath.row]
                }else{
                    player = viewModel.filteredPlayerDataRelay.value[indexPath.row]
                }
                
                if (self.viewModel.chosenPlayers.contains(player))
                {
                    self.viewModel.chosenPlayers.removeObject(object: player)
                    viewModel.currentTeamRelay.accept(viewModel.chosenPlayers)
                    showToast(message: "Removed \(player.knownAs) from current team.")
                }
                else
                {
                    self.viewModel.chosenPlayers.append(player)
                    viewModel.currentTeamRelay.accept(viewModel.chosenPlayers)
                    showToast(message: "Added \(player.knownAs) to current team.")
                }
                
                self.viewModel.currentTeamCountSubject.onNext(viewModel.currentTeamRelay.value.count)
                
                if(currentTeamButton.isSelected){
                    self.viewModel.filteredPlayerDataRelay.accept(viewModel.currentTeamRelay.value)
                    tableView.reloadData()
                }
            }
        }
    }
}

private extension PlayersViewController {
    
    func initializeVM() {
        disposeBag.insert(viewModel.initializeViewModelObservables())
        
        initializeLoaderObservable(subject: viewModel.loaderSubject).disposed(by: disposeBag)
        initializeTopViewObservable(subject: viewModel.topViewSubject).disposed(by: disposeBag)
        
        initializePlayerDataObservable(subject: viewModel.screenPlayerDataRelay).disposed(by: disposeBag)
        
        initializeSinglePlayerVCObservable(subject: viewModel.singlePlayerRelay).disposed(by: disposeBag)
        initializeTeamVCObservable(subject: viewModel.finishedTeamRelay).disposed(by: disposeBag)
        
        initializeTeamNamesDataObservable(subject: viewModel.screenTeamsDataRelay).disposed(by: disposeBag)
        initializeButtonsObservable()
        initializeCurrentTeamCount(subject: viewModel.currentTeamCountSubject).disposed(by: disposeBag)
        
        initializeFavoriteCount(subject: viewModel.favoritedTeamRelay).disposed(by: disposeBag)
        initializeSortName(subject: viewModel.sortFavoriteNameSubject).disposed(by: disposeBag)
        initializeSortPosition(subject: viewModel.sortFavoritePositionSubject).disposed(by: disposeBag)
    }
    
    func initializeFavoriteCount(subject: BehaviorRelay<[Player]>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] _ in
                let count = self.viewModel.favoritedTeamRelay.value.count
                favoriteFilterButton.setTitle("Favorites (\(count))", for: .normal)
            })
    }
    
    func initializeSortName(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] bool in
                var array: [Player]
                if bool {
                    array = self.viewModel.favoritePlayers.sorted(by: {$0.knownAs < $1.knownAs})
                }else{
                    array = self.viewModel.favoritePlayers.sorted(by: {$0.knownAs > $1.knownAs})
                }
                self.viewModel.favoritedTeamRelay.accept(array)
                self.viewModel.filteredPlayerDataRelay.accept(array)
                self.viewModel.sortBool = !bool
                tableView.reloadData()
            })
    }
    
    func initializeSortPosition(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] bool in
                var array: [Player]
                if bool {
                    array = self.viewModel.favoritePlayers.sorted(by: {$0.position < $1.position})
                }else{
                    array = self.viewModel.favoritePlayers.sorted(by: {$0.position > $1.position})
                }
                self.viewModel.favoritedTeamRelay.accept(array)
                self.viewModel.filteredPlayerDataRelay.accept(array)
                self.viewModel.sortBool = !bool
                tableView.reloadData()
            })
    }
    
    func initializeCurrentTeamCount(subject: PublishSubject<Int>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] count in
                acceptTeamButton.setTitle("Proceed with this team (\(count))", for: .normal)
                setAcceptButtonColor(n: count)
            })
    }
    
    func initializeTeamVCObservable(subject: PublishRelay<[Player]>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (players) in
                let custom: CustomTeam = CustomTeam()
                custom.team = players
                self.viewModel.customTeams.append(custom)
                pushNavigation(viewController: DetailsViewController(viewModel: DetailsViewModelImpl(data: custom, teamNamesDictionary: self.viewModel.teamNames)))
            })
    }
    
    func initializeButtonsObservable(){
        let buttons = [allFilterButton, favoriteFilterButton, currentTeamButton].map { $0! }
        
        let selectedButton = Observable.from(
            buttons.map { button in button.rx.tap
                .map { button }
            }
        ).merge()
        
        buttons.reduce(Disposables.create()) { disposable, button in
            let subscription = selectedButton.map { $0 == button }
                .bind(to: button.rx.isSelected)
            
            return Disposables.create(disposable, subscription)
        }.disposed(by: disposeBag)
        
        allFilterButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.filteredPlayerDataRelay.accept(viewModel.screenPlayerDataRelay.value)
                self.viewModel.topViewSubject.onNext("all")
                tableView.reloadData()
            }).disposed(by: disposeBag)
        
        favoriteFilterButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.filteredPlayerDataRelay.accept(viewModel.favoritedTeamRelay.value)
                self.viewModel.topViewSubject.onNext("favorite")
                tableView.reloadData()
            }).disposed(by: disposeBag)
        
        currentTeamButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.filteredPlayerDataRelay.accept(viewModel.currentTeamRelay.value)
                self.viewModel.topViewSubject.onNext("current")
                tableView.reloadData()
            }).disposed(by: disposeBag)
        
        acceptTeamButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                let count = self.viewModel.currentTeamRelay.value.count
                switch count{
                case 2...11:
                    self.viewModel.previousTeamRelay.accept(viewModel.currentTeamRelay.value)
                    self.viewModel.finishedTeamRelay.accept(self.viewModel.currentTeamRelay.value)
                    self.viewModel.currentTeamRelay.accept([])
                    self.viewModel.chosenPlayers.removeAll()
                    self.viewModel.currentTeamCountSubject.onNext(viewModel.currentTeamRelay.value.count)
                    self.viewModel.filteredPlayerDataRelay.accept(viewModel.currentTeamRelay.value)
                    tableView.reloadData()
                default:
                    showToast(message: "Team must consist of 2-11 players.")
                }
            }).disposed(by: disposeBag)
        
        sortNameButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                sortPlayers(value: "name")
            }).disposed(by: disposeBag)
        
        sortPositionButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                sortPlayers(value: "position")
            }).disposed(by: disposeBag)
        
        previousTeamsButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if !self.viewModel.previousTeamRelay.value.isEmpty {
                    self.viewModel.finishedTeamRelay.accept(self.viewModel.previousTeamRelay.value)
                }else{
                    showToast(message: "No team that preceeds current one.")
                }
            }).disposed(by: disposeBag)
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
    
    func initializeTopViewObservable(subject: ReplaySubject<String>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (status) in
                switch(status){
                case "favorite":
                    showFavoriteTopView()
                case "current":
                    showChosenTopView()
                default:
                    showAllTopView()
                }
            })
    }
    
    func initializeTeamNamesDataObservable(subject: BehaviorRelay<[Team]>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (teams) in
                teams.forEach{ team in
                    viewModel.teamNames[team.id] = team.name
                }
                viewModel.loadPlayerDataSubject.onNext(())
            })
    }
    
    func initializePlayerDataObservable(subject: BehaviorRelay<[Player]>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (players) in
                if !players.isEmpty {
                    tableView.reloadData()
                }
            })
    }
    
    func initializeSinglePlayerVCObservable(subject: PublishRelay<Player>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (player) in
                let custom: CustomTeam = CustomTeam()
                custom.player = player
                pushNavigation(viewController: DetailsViewController(viewModel: DetailsViewModelImpl(data: custom, teamNamesDictionary: self.viewModel.teamNames)))
            })
    }
    
}

extension PlayersViewController {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
    
    func showAllTopView(){
        searchTextField.isHidden = false
        currentTeamTopView.isHidden = true
        favoriteTopView.isHidden = true
    }
    
    func showChosenTopView(){
        currentTeamTopView.isHidden = false
        searchTextField.isHidden = true
        favoriteTopView.isHidden = true
    }
    
    func showFavoriteTopView(){
        favoriteTopView.isHidden = false
        currentTeamTopView.isHidden = true
        searchTextField.isHidden = true
    }
    
    func sortPlayers(value: String){
        switch value {
        case "name":
            self.viewModel.sortFavoriteNameSubject.onNext(self.viewModel.sortBool)
        case "position":
            self.viewModel.sortFavoritePositionSubject.onNext(self.viewModel.sortBool)
        default:
            print("sort error: \(value)")
        }
    }
    
    func pushNavigation(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func checkTeamName(id: Int) -> String {
        guard let name = viewModel.teamNames[id] else {return "Unknown"}
        return name
    }
    
    func setAcceptButtonColor(n: Int) {
        switch n {
        case 2...11:
            acceptTeamButton.backgroundColor = .systemGreen
        default:
            acceptTeamButton.backgroundColor = .lightGray
        }
    }
}
