//
//  User.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let lastLogin: String?
    let userType: Int
    let confirmed: String
    let creationToken: String?
    let createdAt: String
    let updatedAt: String
    let studentCenter: String?
    let dob: String?
    let pupilCenter: String?
    let status: String?
    let slug: String
    let logo: [Logo]?
    let companyName: [CompanyName]?
    
    let hasSeasonTag: Bool?
    let userLocations: [UserLocation]?
    let userMeta: [UserMeta]?
    let skills: [Skill]?
    let employerStatements: [String]?
    let consents: [UserConsent]?
}





