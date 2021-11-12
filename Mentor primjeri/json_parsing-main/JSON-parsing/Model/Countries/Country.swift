//
//  Country.swift
//  JSON-parsing
//
//  Created by Danijel Trifunović on 22.02.2021..
//

import Foundation

public struct Country: Codable {
    public let name: String
    public let code2: String
    public let code3: String
    public let callingCode: String?
}
