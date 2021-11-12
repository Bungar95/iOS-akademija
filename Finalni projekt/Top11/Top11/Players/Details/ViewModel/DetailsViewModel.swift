//
//  DetailsViewModel.swift
//  Top11
//
//  Created by Borna Ungar on 29.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
protocol DetailsViewModel: AnyObject {
    
    var playerRelay: PublishRelay<Player> {get}
    var teamRelay: PublishRelay<[Player]> {get}
    var data: CustomTeam {get set}
    var teamNamesDictionary: [Int:String] {get set}
    
    var teamAge: Int {get set}
    var teamHeight: Int {get set}
    var teamWeight: Int {get set}
    var teamAppearances: Int {get set}
    var teamGoals: Int {get set}
    var teamAssists: Int {get set}
    var teamCards: Int {get set}
    
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadDataSubject: ReplaySubject<()> {get}
    
    func getTeamStatistic(players: [Player])
}
