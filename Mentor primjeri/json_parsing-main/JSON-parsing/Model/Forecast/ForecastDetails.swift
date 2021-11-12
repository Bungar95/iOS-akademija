//
//  ForecastDetails.swift
//  JSON-parsing
//
//  Created by Danijel Trifunović on 22.02.2021..
//

import Foundation

public struct ForecastDetails: Codable {
    public let header: ForecastDetailsHeader
    public var parameters: [String: ForecastParameter]
}
