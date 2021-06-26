//
//  DetailsCoordinator.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import UIKit

class DetailsCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var detailsViewController: DetailsViewController!
    var childCoordinators: [Coordinator] = []
    var parentDelegate: ParentCoordinatorDelegate?
    
    init(navController: UINavigationController, person: PersonViewItem) {
        navigationController = navController
        super.init()
        detailsViewController = createDetailsViewController(person: person)
    }
    
    deinit{
        print("Deinit: \(self)")
    }
    
    func start() {
        navigationController.pushViewController(detailsViewController, animated: true)
    }

    func createDetailsViewController(person: PersonViewItem) -> DetailsViewController {
        let viewModel = DetailsViewModelImpl(dependencies: DetailsViewModelImpl.Dependencies(person: person))
        let viewController = DetailsViewController(viewModel: viewModel)
        return viewController
    }
}
extension DetailsCoordinator: CoordinatorDelegate, ParentCoordinatorDelegate{
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        parentDelegate?.childHasFinished(coordinator: self)
    }
    
    func childHasFinished(coordinator: Coordinator) {
        removeChildCoordinator(coordinator: coordinator)
    }
}
