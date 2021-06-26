//
//  HomeItem.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation

public class HomeItem: HomeBaseItem{
    let item: PersonViewItem

    init(identity: String, item: PersonViewItem) {
        self.item = item
        super.init(identity: identity)
    }
}

public class PersonViewItem: Equatable {
    
    public static func == (lhs: PersonViewItem, rhs: PersonViewItem) -> Bool {
        lhs.id == rhs.id
    }
    
    let name: String
    let id: String
    let birthday: String
    let initials: String
    let age: String
    
    init(name: String, id: String, birthday: String, initials: String, age: String) {
        self.name = name
        self.id = id
        self.birthday = birthday
        self.initials = initials
        self.age = age
    }
}
