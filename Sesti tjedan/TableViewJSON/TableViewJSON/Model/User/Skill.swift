//
//  Skill.swift
//  JsonParse
//
//  Created by Borna Ungar on 19.06.2021..
//

import Foundation

public struct Skill: Codable {
    let id: Int
    let name: String
    let parent: Int
    let createdAt: String?
    let updatedAt: String?
    let pivot: Pivot
}
