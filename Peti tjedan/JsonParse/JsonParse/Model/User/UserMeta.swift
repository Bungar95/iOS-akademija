//
//  UserMeta.swift
//  JsonParse
//
//  Created by Borna Ungar on 19.06.2021..
//

import Foundation

struct UserMeta: Codable {
    let id, userId: Int
    let metaKey: String
    let value: Value
    let createdAt, updatedAt: String
    let medium: Medium?
}

enum Value: Codable {
    case array([String])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .array(container.decode(Array.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .array(let array):
            try container.encode(array)
        case .string(let string):
            try container.encode(string)
        }
    }
}

