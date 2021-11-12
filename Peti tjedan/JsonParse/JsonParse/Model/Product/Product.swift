//
//  Product.swift
//  JsonParse
//
//  Created by Borna Ungar on 19.06.2021..
//

import Foundation
public struct Product: Codable {
    let id: Int
    let name: String
    let shortDescription: String
    let fullDescription: String
    let group: GroupType
    let packageUnit: String
    let isOrganic: Bool
    let thumbnail: Image
    let image: Image
    let leaflet: Image
    let updatedAt: DateCommon
}
