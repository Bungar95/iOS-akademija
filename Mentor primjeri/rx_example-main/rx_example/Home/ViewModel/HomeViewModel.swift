//
//  HomeViewModel.swift
//  rx_example
//
//  Created by Zvonimir Medak on 04.03.2021..
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModel {
    var screenDataRelay: BehaviorRelay<[SongList]> {get}
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadDataSubject: ReplaySubject<()> {get}
    
    func initializeViewModelObservables() -> [Disposable]
}
