//
//  AppCoordinator.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import UIKit

class AppCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var window: UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    
    func start() {
        let presenter = UINavigationController()
        window.rootViewController = presenter
        window.makeKeyAndVisible()
        createHomeCoordinator(presenter: presenter)
    }
    
    func createHomeCoordinator(presenter: UINavigationController){
        let homeCoordinator = HomeCoordinator(navController: presenter)
        self.addChildCoordinator(coordinator: homeCoordinator)
        homeCoordinator.start()
    }
}

extension AppCoordinator: CoordinatorDelegate{
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        removeChildCoordinator(coordinator: self)
    }
}
