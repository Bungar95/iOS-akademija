//
//  Player.swift
//  Top11
//
//  Created by Borna Ungar on 26.07.2021..
//

import Foundation
struct Player: Codable, Equatable {
    
    let id: Int
    let fullName: String
    let knownAs: String
    let age: Int
    let height: Int
    let weight: Int
    let league: String
    let url: String
    let clubTeamId: Int
    let position: String
    let birthday: Int
    let nationality: String
    let appearancesOverall: Int
    let goalsOverall: Int
    let cleanSheetsOverall: Int
    let assistsOverall: Int
    let cardsOverall: Int
    let redCardsOverall: Int
    let yellowCardsOverall: Int
}
