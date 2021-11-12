//
//  JobFinance.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation
struct JobFinance: Codable {
    let id, jobOfferId, financesType, amount: Int
    let createdAt, updatedAt, amountFormatted: String

}
