//
//  CompanyName.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct CompanyName: Codable {
    let id: Int
    let userId: Int
    let metaKey: String
    let value: String
    let createdAt: String
    let updatedAt: String
}
