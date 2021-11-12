//
//  Crop.swift
//  JSON-parsing
//
//  Created by Danijel Trifunović on 22.02.2021..
//

import Foundation

public struct Crop: Codable {
    public let id: Int
    public let name: String
    public let shortDescription: String
    public let fullDescription: String?
    public let enabledForFertCalculator: Bool?
    public let enabledForFieldActivity: Bool?
    public let isFavourite: Bool?
    public let group: CropGroup
    public let image: ServerFileData
    public let updatedAt: PublishDate?
}
