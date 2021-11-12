//
//  Consent.swift
//  JsonParse
//
//  Created by Borna Ungar on 19.06.2021..
//

import Foundation
public struct Consent: Codable {
    let id: Int
    let title: String
    let consent: String
    let uniqueId: String
    let createdAt: String?
    let updatedAt: String?

}
