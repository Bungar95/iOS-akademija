//
//  FertiliserViewController.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 25.06.2021..
//

import UIKit
class FertiliserViewController: UIViewController {
    
    var fertiliserGroups = [Fertiliser]()
    
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
        fertiliserGroups = getFertilisers()
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

private extension FertiliserViewController {
    
    func getFertilisers() -> [Fertiliser] {
        let serializationManager = SerializationManager()
        if let localData = serializationManager.readLocalFile(forName: "fertiliser_result"),
           let responseData: Response<[Fertiliser]> = serializationManager.parse(jsonData: localData){
            return responseData.data ?? []
        }
        print ("prazno")
        return []
    }
}

private extension FertiliserViewController {
    
    func registerCells() {
        tableView.register(FertiliserTableViewCell.self, forCellReuseIdentifier: "fertiliserTableViewCell")
    }
}

extension FertiliserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Fertiliser: \(fertiliserGroups[section].name)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        fertiliserGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fertiliserGroups[section].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fertiliserTableViewCell", for: indexPath as IndexPath) as? FertiliserTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let fertiliser = fertiliserGroups[indexPath.section]
        let fertiliserProduct = fertiliser.products[indexPath.row]
        
        cell.configureCell(name: fertiliser.name, id: fertiliser.id, productName: fertiliserProduct.name, value: fertiliserProduct.maxValue, isSecondSection: indexPath.section == 1)
        
        return cell
    
    }
    
}
