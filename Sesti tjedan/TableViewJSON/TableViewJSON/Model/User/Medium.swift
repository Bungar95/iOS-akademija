//
//  Medium.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct Medium: Codable {
    let id: Int
    let filePath: String
    let width: Int
    let height: Int
    let fileType: String
    let storageType: String
    let fileSize: Int
    let createdAt: String
    let updatedAt: String
    let imageName: String
    let sizes: [Size]
    let userId: Int?

}
