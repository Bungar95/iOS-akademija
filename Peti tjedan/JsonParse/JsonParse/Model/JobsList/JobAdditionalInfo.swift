//
//  Benefit.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

struct JobAdditionalInfo: Codable {
    let id: Int
    let name: String
    let createdAt: String?
    let updatedAt: String?
    let slug: String?
    let parent: Int?

}
