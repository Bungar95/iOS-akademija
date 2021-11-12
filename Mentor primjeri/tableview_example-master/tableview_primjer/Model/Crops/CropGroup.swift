//
//  CropGroup.swift
//  tableview_primjer
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation

public class CropGroup: Codable {
    public let id: Int
    public let name: String
    public let slug: String
    public let crops: [Crop]?
    
}
