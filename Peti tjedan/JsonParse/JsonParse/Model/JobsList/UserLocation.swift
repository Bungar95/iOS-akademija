//
//  UserLocation.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct UserLocation: Codable {
    let id: Int
    let userId: Int?
    let geoLocationId: Int
    let contactPerson: Int?
    let locationType: String
    let address: String?
    let zipCode: String?
    let createdAt: String
    let updatedAt: String
    let lat: Double?
    let lng: Double?
    let customName: String?
    let geoLocation: GeoLocation
}
