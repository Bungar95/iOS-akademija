//
//  RelatedPost.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct RelatedPost: Codable {
    let id: Int
    let title, excerpt: String
    let image: String
    let categoryId: Int
    let group: ArticleGroup
}
