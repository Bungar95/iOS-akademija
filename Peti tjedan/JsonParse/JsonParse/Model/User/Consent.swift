//
//  Consent.swift
//  JsonParse
//
//  Created by Borna Ungar on 19.06.2021..
//

import Foundation
struct Consent: Codable {
    let id: Int
    let title, consent, uniqueId: String
    let createdAt, updatedAt: String?

}
