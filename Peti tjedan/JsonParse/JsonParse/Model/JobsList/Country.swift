//
//  Country.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct Country: Codable {
    let id: Int
    let name: String
    let code: String
    let iso: String
    let zone: String
    let createdAt: String?
    let updatedAt: String?
}
