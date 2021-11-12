//
//  HealthStats.swift
//  JsonParse
//
//  Created by Borna Ungar on 17.06.2021..
//

import Foundation

public struct HealthStats: Codable {
    
    public let weight: Double
    public let date: String
    public let systolicBp: Int?
    public let diastolicBp: Int?
    public let diabetes: Int?

    
}
