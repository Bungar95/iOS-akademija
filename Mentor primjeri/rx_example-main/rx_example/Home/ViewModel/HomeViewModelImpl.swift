//
//  HomeViewModel.swift
//  rx_example
//
//  Created by Zvonimir Medak on 04.03.2021..
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModelImpl: HomeViewModel {
    
    var screenDataRelay = BehaviorRelay<[SongList]>.init(value: [])
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    
    private let songsRepository: SongsRepository
    
    init(songsRepository: SongsRepository) {
        self.songsRepository = songsRepository
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadSongsSubject(subject: loadDataSubject))
        return disposables
    }
}

private extension HomeViewModelImpl {
    
    func initializeLoadSongsSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<SongResponse> in
                self.loaderSubject.onNext(true)
                return self.songsRepository.getSongs()
            }
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (songResponse) in
                guard let songs = songResponse.tracks?.data else {
                    return
                }
                self.screenDataRelay.accept(songs)
                self.loaderSubject.onNext(false)
            })
    }
}

