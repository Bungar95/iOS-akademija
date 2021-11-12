//
//  JobLanguage.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
struct JobLanguage: Codable {
    let id, jobId, languageId: Int
    let understanding, speaking, writing: String?
    let createdAt, updatedAt: String
    let score: String?
    let language: Language

}
