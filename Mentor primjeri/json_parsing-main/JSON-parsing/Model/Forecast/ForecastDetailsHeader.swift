//
//  ForecastDetailsHeader.swift
//  JSON-parsing
//
//  Created by Danijel Trifunović on 22.02.2021..
//

import Foundation

public struct ForecastDetailsHeader: Codable {
    public let time: Int
    public let summary: String
    public let icon: ForecastIcon
    public let temperature: ForecastParameter?
    public let temperatureMax: ForecastParameter?
    public let temperatureMin: ForecastParameter?
    
    enum CodingKeys: String, CodingKey{
        case time
        case summary
        case icon
        case temperature
        case temperatureMax = "tMax"
        case temperatureMin = "temeprature_min"
    }
}
