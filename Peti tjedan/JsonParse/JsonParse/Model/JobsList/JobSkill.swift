//
//  JobSkill.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
struct JobSkill: Codable {
    let id, jobId, skillId: Int
    let createdAt, updatedAt: String
    let skill: JobAdditionalInfo

}
