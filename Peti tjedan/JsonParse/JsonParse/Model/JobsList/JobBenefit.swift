//
//  JobBenefit.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
public struct JobBenefit: Codable {
    let id: Int
    let jobId: Int
    let benefitId: Int
    let createdAt: String
    let updatedAt: String
    let benefit: JobAdditionalInfo
}
