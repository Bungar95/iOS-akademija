//
//  Logo.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct Logo: Codable {
    let id: Int
    let userId: Int?
    let metaKey: String?
    let value: String?
    let createdAt: String
    let updatedAt: String
    let filePath: String
    let width: Int
    let height: Int
    let fileType: String
    let storageType: String
    let fileSize: Int
    let imageName: String
    let sizes: [Size]
    
    
}
