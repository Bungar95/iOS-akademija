//
//  JobCertificate.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

struct JobCertificate: Codable {
    let id, jobId, certificateId: Int
    let createdAt, updatedAt: String
    let certificate: JobAdditionalInfo

}
