//
//  Response.swift
//  JsonParse
//
//  Created by Borna Ungar on 16.06.2021..
//

import Foundation

public class Response<T: Codable>: Codable {
    public let status: String?
    public let message: String?
    public let apiVersion: String?
    public let context: String?
    public let httpCode: Int?
    public let method: String?
    public let baseUrl: String?
    public let uri: String?
    public let errors:  String?
    public let queryParameters: Query?
    
    public let data:T?
    
    public init(data: T, status: String, message: String, apiVersion: String, context: String, httpCode: Int, method: String, baseUrl: String, uri: String, errors: String, query: Query) {
        self.status = status
        self.message = message
        self.apiVersion = apiVersion
        self.context = context
        self.httpCode = httpCode
        self.method = method
        self.baseUrl = baseUrl
        self.uri = uri
        self.errors = errors
        self.queryParameters = query
        self.data = data
    }
    
}

public enum Query: Codable {
    case array([QueryParameters])
    case string(QueryParameters)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .array(container.decode(Array.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(container.decode(QueryParameters.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(QueryParameters.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .array(let array):
            try container.encode(array)
        case .string(let string):
            try container.encode(string)
        }
    }
}

