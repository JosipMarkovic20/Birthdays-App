//
//  HomeViewModel.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModelImpl: HomeViewModel {
    var loaderPublisher = PublishSubject<Bool>()
    var input: ReplaySubject<HomeInput> = ReplaySubject.create(bufferSize: 1)
    var output: BehaviorRelay<HomeOutput> = BehaviorRelay.init(value: HomeOutput(items: [], event: nil))
    
    public struct Dependencies {
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
}

extension HomeViewModelImpl {
    
    func bindViewModel() -> [Disposable] {
        var disposables = [Disposable]()
        return disposables
    }
    

}

protocol HomeViewModel {
    func bindViewModel() -> [Disposable]
    var loaderPublisher: PublishSubject<Bool> {get}
    var input: ReplaySubject<HomeInput> {get}
    var output: BehaviorRelay<HomeOutput> {get}
}
