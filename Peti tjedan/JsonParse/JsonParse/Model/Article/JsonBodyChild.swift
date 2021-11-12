//
//  JsonBodyChild.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct JsonBodyChild: Codable {
    let tag: String
    let children: [JsonBodyChild2nd]
    let html: String
}
