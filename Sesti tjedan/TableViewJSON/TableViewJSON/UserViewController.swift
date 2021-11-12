//
//  UserViewController.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 27.06.2021..
//

import Foundation
import UIKit

class UserViewController: UIViewController {
    
    var user: User?
    
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
        user = getUser()
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

private extension UserViewController {
    
    func getUser() -> User? {
        let serializationManager = SerializationManager()
        if let localData = serializationManager.readLocalFile(forName: "user_response"),
           let responseData: Response<User> = serializationManager.parse(jsonData: localData),
           let data = responseData.data{
            return data
        }
        print ("prazno")
        return nil
    }
}

private extension UserViewController {
    
    func registerCells() {
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "userTableViewCell")
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var userName = "Unknown"
        if let userForCell = user {
            userName = "\(userForCell.firstName) \(userForCell.lastName)"
        }
        return userName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userTableViewCell", for: indexPath as IndexPath) as? UserTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        if let userForCell = user {

            cell.configureCell(email: userForCell.email, dob: userForCell.dob, location: userForCell.userLocations[indexPath.row].geoLocation.title, isSecondSection: indexPath.section == 1)
            }
        
        return cell
    
    }
}
