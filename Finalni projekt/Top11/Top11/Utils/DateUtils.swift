//
//  DateUtils.swift
//  Top11
//
//  Created by Borna Ungar on 01.08.2021..
//

import Foundation

public class DateUtils {
    
    static let dobTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }()
    
    static let currentTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:hh dd-MM-yyyy"
        return dateFormatter
    }()
    
    public static func getDateOfBirthFromTimestamp(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        return dobTimeFormatter.string(from: date)
    }
    
    public static func getCreatedAtFromTimestamp(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        return currentTimeFormatter.string(from: date)
    }
}
