//
//  JsonBody.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct JsonBody: Codable {
    let tag: String
    let children: [JsonBodyChild]
}
