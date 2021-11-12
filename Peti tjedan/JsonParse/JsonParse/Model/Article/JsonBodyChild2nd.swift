//
//  JsonBodyChild2nd.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

struct JsonBodyChild2nd: Codable {
    let tag: String
    let html: String?
    let children: [JsonBodyChild3rd]?
}
