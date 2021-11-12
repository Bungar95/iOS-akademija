//
//  ArticleChild.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct ArticleChild: Codable {
    let id: Int
    let title: String
    let excerpt: String
    let image: String
    let categoryId: Int
    let group: ArticleGroup
}
