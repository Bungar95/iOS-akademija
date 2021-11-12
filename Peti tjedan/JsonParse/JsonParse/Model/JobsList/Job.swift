//
//  Jobs.swift
//  JsonParse
//
//  Created by Borna Ungar on 18.06.2021..
//

import Foundation

public class Job: Codable {
    
    let id: Int
    let userId: Int?
    let title: String
    let subtitle: String?
    let description: String
    let workersNeeded: String
    let numberOfHours: String?
    let jobImage: Int?
    let adDuration: String
    let workingTimeType: Int
    let jobStart: String?
    let jobEnd: String?
    let status: String
    let createdAt: String
    let updatedAt: String
    let employerLocation: Int
    let slug: String
    let notifiedRejections: Int?
    let notifiedInactivation: String?
    let tag: String?
    let updatable: String?
    let hidden: Int
    let customLoginLink: String?
    let dispatchedForSavedSearches: Int?
    let jobLink: String
    let userLocation: UserLocation
    let user: User?
    let medium: Medium?
    let jobBenefits: [JobBenefit]
    let jobCertificates: [JobCertificate]
    let jobLanguages: [JobLanguage]
    let jobOffersMeta: [String]?
    let jobSkills: [JobSkill]
    let jobWorkingHours: [String]?
    let jobFinances: [JobFinance]
    let jobEmployeeCategories: [JobEmployeeCategory]
    let jobOfferCategories: [JobOfferCategory]
    let jobOfferImpressionCounter: JobOfferCounter
    let jobOfferApplicationsCounter: JobOfferCounter?
}
