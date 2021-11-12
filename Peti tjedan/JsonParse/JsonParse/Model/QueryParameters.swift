//
//  QueryParameters.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct QueryParameters: Codable {
    let country: String?
    let orderBy: String?
    let sortOrder: String?
    let category: String?
    let areaSize: String?
    let areaSizeUnit: String?
    let cropID: String?
    let isOrganic: String?

}
