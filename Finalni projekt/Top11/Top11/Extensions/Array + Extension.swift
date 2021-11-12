//
//  Array + Extension.swift
//  Top11
//
//  Created by Borna Ungar on 30.07.2021..
//

import Foundation
extension Array where Element : Equatable {
    mutating func removeObject(object : Iterator.Element) {
        if let index = self.firstIndex(of: object) {
            self.remove(at: index)
        }
    }
}
