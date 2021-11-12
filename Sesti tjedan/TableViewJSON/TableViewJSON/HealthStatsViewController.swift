//
//  HealthStatsViewController.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 27.06.2021..
//

import Foundation
import UIKit

class HealthStatsViewController: UIViewController {
    
    var statsGroups = [HealthStats]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        statsGroups = getStats()
        registerCells()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}

private extension HealthStatsViewController {
    
    func getStats() -> [HealthStats] {
        let serializationManager = SerializationManager()
        if let localData = serializationManager.readLocalFile(forName: "data_success_response"),
           let responseData: Response<[HealthStats]> = serializationManager.parse(jsonData: localData){
            return responseData.data ?? []
        }
        print ("prazno")
        return []
    }
}

private extension HealthStatsViewController {
    
    func registerCells() {
        tableView.register(StatsTableViewCell.self, forCellReuseIdentifier: "statsTableViewCell")
    }
}

extension HealthStatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statsGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "statsTableViewCell", for: indexPath as IndexPath) as? StatsTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let stats = statsGroups[indexPath.row]
        
        cell.configureCell(sys: stats.systolicBp, dia: stats.diastolicBp, diabetes: stats.diabetes, weight: stats.weight, date: stats.date, isSecondSection: indexPath.section == 1)
        
        return cell
    
    }
}
