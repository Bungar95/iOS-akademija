//
//  DateUtil.swift
//  JsonParse
//
//  Created by Borna Ungar on 16.06.2021..
//

import Foundation

public class DateUtil {
    
    static let forecastTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "hr")
        dateFormatter.amSymbol = ""
        dateFormatter.pmSymbol = ""
        return dateFormatter
    }()
    
    public static func getForecastTimeFromTimestamp(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        return forecastTimeFormatter.string(from: date)
    }
}
