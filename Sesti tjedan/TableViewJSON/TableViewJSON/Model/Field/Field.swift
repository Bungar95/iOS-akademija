//
//  Field.swift
//  TableViewJSON
//
//  Created by Borna Ungar on 25.06.2021..
//

import Foundation

public struct Field: Codable {
    
    let id: Int
    let name: String
    let surface: String
    let unit: String
    let arCode: String
    let surfaceInM2: String
    
}
