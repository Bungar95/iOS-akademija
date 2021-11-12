//
//  TableViewController.swift
//  tableview_primjer
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    var cropGroups = [CropGroup]()
    
    let tv: UITableView = {
       let tv = UITableView()
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cropGroups = getCrops()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

private extension TableViewController {
    
    func registerCells() {
        tableView.register(CropTableViewCell.self, forCellReuseIdentifier: "cropTableViewCell")
    }
}

private extension TableViewController {
    
    func getCrops() -> [CropGroup] {
        let serializationManager = SerializationManager()
        if let localData = serializationManager.readLocalFile(forName: "crops"),
           let responseData: Response<[CropGroup]> = serializationManager.parse(jsonData: localData),
           let data = responseData.data {
            return data
        }
        return []
    }
}

extension TableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return cropGroups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cropGroups[section].crops?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cropCell = tableView.dequeueReusableCell(withIdentifier: "cropTableViewCell", for: indexPath) as? CropTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        guard let crop = cropGroups[indexPath.section].crops?[indexPath.row] else {
            print("failed to get the crop")
            return UITableViewCell()
        }
        
        cropCell.configureCell(name: crop.name, time: crop.updatedAt?.display ?? "", isSecondSection: indexPath.section == 1)
        return cropCell
    }
}
