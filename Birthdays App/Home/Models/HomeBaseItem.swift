//
//  HomeBaseItem.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import RxDataSources

public class HomeBaseItem: IdentifiableType, Equatable{
    public static func ==(lhs: HomeBaseItem, rhs: HomeBaseItem) -> Bool {
        lhs.identity == rhs.identity
    }
    
    public let identity: String
    
    
    public init(identity: String){
        self.identity = identity
    }
    
}
