//
//  Size.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct Size: Codable {
    let name: String
    let width: Int
    let height: Int?
    let imageName: String
    let filePath: String
    let relativeFilePath: String
    let quality: Int?
}
