//
//  JobOfferCounter.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
struct JobOfferCounter: Codable {
    let id: Int
    let createdAt, updatedAt: String
    let jobId, counter: Int

}
