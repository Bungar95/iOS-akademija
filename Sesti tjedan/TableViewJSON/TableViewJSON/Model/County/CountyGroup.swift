//
//  CountyGroup.swift
//  JsonParse
//
//  Created by Borna Ungar on 16.06.2021..
//

import Foundation

public struct CountyGroup: Codable {
    
    public let currentPage: Int
    public let county: [County]
    public let firstPageUrl: String
    public let from: Int
    public let lastPage: Int
    public let lastPageUrl: String
    public let nextPageUrl: String?
    public let path: String
    public let perPage: String
    public let prevPageUrl: String?
    public let to: Int
    public let total: Int
    
    enum CodingKeys: String, CodingKey{
        case currentPage, firstPageUrl, from, lastPage, lastPageUrl, nextPageUrl, path, perPage, prevPageUrl, to, total
        case county = "data"
    }
}
