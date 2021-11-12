//
//  CropGroup.swift
//  JSON-parsing
//
//  Created by Danijel Trifunović on 22.02.2021..
//

import Foundation

public class CropGroup: Codable {
    public let id: Int
    public let name: String
    public let slug: String
    public let crops: [Crop]?
    
}
