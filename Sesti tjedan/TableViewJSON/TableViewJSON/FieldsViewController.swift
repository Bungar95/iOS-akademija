//
//  File.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 25.06.2021..
//

import UIKit

class FieldsViewController: UIViewController {
    
    var fieldGroups = [Field]()
    
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
        fieldGroups = getField()
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

private extension FieldsViewController {
    
    func getField() -> [Field] {
        let serializationManager = SerializationManager()
        if let localData = serializationManager.readLocalFile(forName: "fields_response"),
           let responseData: Response<[Field]> = serializationManager.parse(jsonData: localData){
            return responseData.data ?? []
        }
        print ("prazno")
        return []
    }
}

private extension FieldsViewController {
    
    func registerCells() {
        tableView.register(FieldTableViewCell.self, forCellReuseIdentifier: "fieldTableViewCell")
    }
}

extension FieldsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fieldTableViewCell", for: indexPath as IndexPath) as? FieldTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let field = fieldGroups[indexPath.row]
        
        cell.configureCell(name: field.name, id: field.id, surface: field.surface, unit: field.unit, isSecondSection: indexPath.section == 1)
        
        return cell
    
    }
}

