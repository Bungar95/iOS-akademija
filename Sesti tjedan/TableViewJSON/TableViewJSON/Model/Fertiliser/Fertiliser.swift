//
//  Fertiliser.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct Fertiliser: Codable {
    let id: Int
    let name: String
    let slug: String
    let products: [FertiliserProduct]
}
