//
//  UserConsent.swift
//  JsonParse
//
//  Created by Borna Ungar on 19.06.2021..
//

import Foundation
public struct UserConsent: Codable {
    let id: String
    let userId: String
    let consentId: Int
    let status: String
    let createdAt: String
    let updatedAt: String
    let consent: Consent

}
