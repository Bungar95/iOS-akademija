//
//  Response.swift
//  tableview_primjer
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation

public class Response<T: Codable>: Codable {
    public let data:T?
    
    public init(data: T) {
        self.data = data
    }
}
