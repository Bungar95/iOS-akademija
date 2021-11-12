//
//  ActivityField.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct ActivityField: Codable {
    let id: Int
    let name: String
    let surface: String
    let unit: String
    let arCode: String
    let surfaceInM2: String
}
