//
//  Product.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct FertiliserProduct: Codable {
    let id: Int
    let name: String
    let shortDescription: String
    let fullDescription: String
    let packageUnit: String
    let isOrganic: Bool
    let maxValue: Double
    let note: String?
    let minValue: Double?
}
