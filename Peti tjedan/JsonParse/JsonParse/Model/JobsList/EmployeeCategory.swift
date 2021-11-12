//
//  EmployeeCategory.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
struct EmployeeCategory: Codable {
    let id: Int
    let employeeType: String
    let order: Int
    let createdAt, updatedAt: String?
    let employeeTypeName: String

}
