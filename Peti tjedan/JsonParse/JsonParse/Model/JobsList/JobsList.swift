//
//  JobsList.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct JobsList: Codable {
    let currentPage: Int
    let jobs: [Job]
    
    enum CodingKeys: String, CodingKey {
        case currentPage
        case jobs = "data"
    }
}
