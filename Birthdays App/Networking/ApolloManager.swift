//
//  ApolloManager.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import Apollo
import RxSwift

public enum ApolloError: Error {
    case gqlErrors([GraphQLError])
}

public class ApolloManager{
    private static let graphQLEndpoint: String = Bundle.main.infoDictionary!["GRAPH_QL_ENDPOINT"] as! String
    private static let apollo = ApolloClient(url: URL(string:graphQLEndpoint)!)
    
    public static func requestObservable<Query: GraphQLQuery>(query: Query) -> Observable<Query.Data>{
        return Observable.create { (emitter) -> Disposable in
            let cancellable = apollo.fetch(query: query,
                                           cachePolicy: CachePolicy.returnCacheDataElseFetch,
                                           contextIdentifier: nil,
                                           queue: DispatchQueue.main) { result in
                switch result{
                case .success(let value):
                    if let errors = value.errors{
                        emitter.onError(ApolloError.gqlErrors(errors))
                    }else if let data = value.data  {
                        emitter.onNext(data)
                    }else{
                        emitter.onCompleted()
                    }
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
}
