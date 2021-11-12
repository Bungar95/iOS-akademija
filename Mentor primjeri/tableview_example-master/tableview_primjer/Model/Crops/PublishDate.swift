//
//  PublishDate.swift
//  tableview_primjer
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation

public struct PublishDate: Codable {
    public let display: String
    public let date: String
    public let datetime: String
    public let timestamp: Int
    public let datepickerFormat: String?
}
