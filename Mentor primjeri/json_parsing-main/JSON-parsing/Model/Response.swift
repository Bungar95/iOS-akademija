//
//  Response.swift
//  JSON-parsing
//
//  Created by Danijel Trifunović on 22.02.2021..
//

import Foundation

public class Response<T: Codable>: Codable {
    public let data:T?
    
    public init(data: T) {
        self.data = data
    }
}
