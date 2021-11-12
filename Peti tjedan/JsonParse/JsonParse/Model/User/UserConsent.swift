//
//  UserConsent.swift
//  JsonParse
//
//  Created by Borna Ungar on 19.06.2021..
//

import Foundation
struct UserConsent: Codable {
    let id, userId, consentId: Int
    let status, createdAt, updatedAt: String
    let consent: Consent

}
