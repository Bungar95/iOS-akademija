//
//  JobEmployeeCategory.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
struct JobEmployeeCategory: Codable {
    let id, jobId, employeeCategoryId: Int
    let createdAt, updatedAt: String
    let employeeCategory: EmployeeCategory

}
