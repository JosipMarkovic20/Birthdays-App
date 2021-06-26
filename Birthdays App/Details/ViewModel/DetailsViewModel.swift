//
//  DetailsViewModel.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import RxSwift
import RxCocoa

class DetailsViewModelImpl: DetailsViewModel {
    
    var input: ReplaySubject<DetailsInput> = ReplaySubject.create(bufferSize: 1)
    var output: BehaviorRelay<DetailsOutput> = BehaviorRelay.init(value: DetailsOutput(item: nil, event: nil))
    
    public struct Dependencies {
        let person: PersonViewItem
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
}

extension DetailsViewModelImpl {
    
    func bindViewModel() -> [Disposable] {
        var disposables = [Disposable]()
        disposables.append(self.input
                            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                            .flatMap{ [unowned self] (input) -> Observable<DetailsOutput> in
                                switch input{
                                case .loadData:
                                    return .just(.init(item: dependencies.person, event: .reloadData))
                                case .backClicked:
                                    return .just(.init(item: dependencies.person, event: .popController))
                                }
                            }.bind(to: output))
        return disposables
    }
}

protocol DetailsViewModel {
    func bindViewModel() -> [Disposable]
    var input: ReplaySubject<DetailsInput> {get}
    var output: BehaviorRelay<DetailsOutput> {get}
}
