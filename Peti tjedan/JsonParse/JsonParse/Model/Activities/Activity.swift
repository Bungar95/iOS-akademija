//
//  Activity.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public struct Activity: Codable {
    let id: Int
    let type: GroupType
    let crop: ActivityCrop
    let field: ActivityField
    let value: String
    let currency: String
    let quantity: String
    let unit: String
    let date: DateCommon
}
