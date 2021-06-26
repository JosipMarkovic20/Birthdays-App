//
//  BirthdayRepository.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import RxSwift

class BirthdaysRepositoryImpl: BirthdayRepository{
    func getPersons() -> Observable<Result<PersonsQuery.Data, Error>> {
        let query = PersonsQuery()
        let observable: Observable<Result<PersonsQuery.Data, Error>> = ApolloManager.requestObservable(query: query).handleError()
        return observable
    }
    
}

protocol BirthdayRepository{
    func getPersons() -> Observable<Result<PersonsQuery.Data, Error>>
}
