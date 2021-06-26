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
        let birthdaysRepository: BirthdaysRepositoryImpl
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
}

extension HomeViewModelImpl {
    
    func bindViewModel() -> [Disposable] {
        var disposables = [Disposable]()
        disposables.append(self.input
                            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                            .flatMap{ [unowned self] (input) -> Observable<HomeOutput> in
                                switch input{
                                case .loadData:
                                    return handleDataLoad()
                                case .personClicked(indexPath: let indexPath):
                                    return handlePersonClick(at: indexPath)
                                }
                            }.bind(to: output))
        return disposables
    }
    
    func handleDataLoad() -> Observable<HomeOutput>{
        self.loaderPublisher.onNext(true)
        return dependencies.birthdaysRepository
            .getPersons()
            .flatMap {[unowned self] result -> Observable<HomeOutput> in
                self.loaderPublisher.onNext(false)
                switch result{
                case .success(let data):
                    return .just(.init(items: createScreenData(from: data.person), event: .reloadData))
                case .failure(let error):
                    return .just(.init(items: [], event: .error(error.localizedDescription)))
                }
        }
    }
    
    func handlePersonClick(at indexPath: IndexPath) -> Observable<HomeOutput>{
        if let item = output.value.items[indexPath.section].items[indexPath.row] as? HomeItem{
            return .just(.init(items: output.value.items, event: .openDetails(person: item.item)))
        }
        return .just(.init(items: output.value.items, event: nil))
    }
    
    func createScreenData(from persons: [PersonsQuery.Data.Person]) -> [HomeSectionItem]{
        var screenData = [HomeSectionItem]()
        screenData.append(HomeSectionItem(identity: "personSection", items: persons.map({ person -> HomeItem in
            let initials = person.name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            let age = DateUtils.getAge(from: person.dateOfBirth)
            let ageString = age == 1 ? "\(age) \(R.string.localizible.year_old().uppercased())" : "\(age) \(R.string.localizible.years_old().uppercased())"
            return HomeItem(identity: person.id, item: PersonViewItem(name: person.name,
                                                                      id: person.id,
                                                                      birthday: person.dateOfBirth,
                                                                      initials: initials,
                                                                      age: ageString))
        })))
        return screenData
    }
}

protocol HomeViewModel {
    func bindViewModel() -> [Disposable]
    var loaderPublisher: PublishSubject<Bool> {get}
    var input: ReplaySubject<HomeInput> {get}
    var output: BehaviorRelay<HomeOutput> {get}
}
