//
//  ViewController.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 21.06.2021..
//

import UIKit

class CountiesViewController: UIViewController {
    
    var countyGroups = [County]()
    
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
        countyGroups = getCounties()
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

private extension CountiesViewController {
    
    func getCounties() -> [County] {
        let serializationManager = SerializationManager()
        if let localData = serializationManager.readLocalFile(forName: "counties_list"),
           let responseData: Response<CountyGroup> = serializationManager.parse(jsonData: localData),
           let data = responseData.data {
            return data.county
            }
        print ("prazno")
        return []
    }
}

private extension CountiesViewController {
    
    func registerCells() {
        tableView.register(CountyTableViewCell.self, forCellReuseIdentifier: "countyTableViewCell")
    }
}

extension CountiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Counties:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countyGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countyTableViewCell", for: indexPath as IndexPath) as? CountyTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let county = countyGroups[indexPath.row]
        
        cell.configureCell(name: county.name, id: county.id, isSecondSection: indexPath.section == 1)
        
        return cell
    
    }
    
}
