//
//  HomeItem.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation

public class HomeItem: HomeBaseItem{
    let item: PersonsQuery

    init(identity: String, item: PersonsQuery) {
        self.item = item
        super.init(identity: identity)
    }
}

