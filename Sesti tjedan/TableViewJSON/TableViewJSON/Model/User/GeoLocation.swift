//
//  Geolocation.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct GeoLocation: Codable {
    let id: Int
    let title: String
    let placeId: String
    let gogoleId: String?
    let lat: Double
    let lng: Double
    let countyId: Int
    let createdAt: String?
    let updatedAt: String?
    let country: Int
    let postCode: String
    let county: JobCounty
}
