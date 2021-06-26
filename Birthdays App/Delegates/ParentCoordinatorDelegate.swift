//
//  ParentCoordinatorDelegate.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation

protocol ParentCoordinatorDelegate: AnyObject {
    func childHasFinished(coordinator: Coordinator)
}
