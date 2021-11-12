//
//  JobOfferCategory.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
struct JobOfferCategory: Codable {
    let id, jobId, categoryId: Int
    let createdAt, updatedAt: String
    let userId: Int
    let jobCategory: JobAdditionalInfo

}
