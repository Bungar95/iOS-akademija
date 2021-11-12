//
//  RequestUrl.swift
//  Top11
//
//  Created by Borna Ungar on 26.07.2021..
//

import Foundation
enum RequestUrl {
    case getPlayers
    case getTeams
    
    var url: String {
        switch self {
        case .getPlayers:
            return "https://api.football-data-api.com/league-players?key=example&season_id=2012"
        case .getTeams:
            return "https://api.football-data-api.com/league-teams?key=example&season_id=2012"
        }
    }
}
