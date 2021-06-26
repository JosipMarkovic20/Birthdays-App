//
//  DetailsOutput.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation

struct DetailsOutput{
    var item: PersonViewItem?
    var event: DetailsOutputEvent?
}

enum DetailsOutputEvent{
    case reloadData
    case error(_ message: String)
    case popController
}
