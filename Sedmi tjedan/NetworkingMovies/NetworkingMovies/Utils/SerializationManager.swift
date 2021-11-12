//
//  SerializationManager.swift
//  NetworkingMovies
//
//  Created by Borna Ungar on 30.06.2021..
//

import Foundation
class SerializationManager {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-DD"
        return dateFormatter
    }()

    public func parse<T: Codable>(jsonData: Data) -> T?{
        let object: T?
        do {
            object = try SerializationManager.jsonDecoder.decode(T.self, from: jsonData)
            
        } catch {
            print("decode error")
            object = nil
        }
        return object
    }
}
