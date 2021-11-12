//
//  PublishDate.swift
//  JSON-parsing
//
//  Created by Danijel Trifunović on 22.02.2021..
//

import Foundation

public struct PublishDate: Codable {
    public let display: String
    public let date: String
    public let datetime: String
    public let timestamp: Int
    public let datepickerFormat: String?
}
