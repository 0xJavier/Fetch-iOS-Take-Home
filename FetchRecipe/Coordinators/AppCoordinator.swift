//
//  AppCoordinator.swift
//  FetchRecipe
//
//  Created by Javier Munoz on 1/8/25.
//

import HomeFeature
import Models
import Networking
import RecipeDetailFeature
import SafariServices
import SwiftUI

final class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let service: RecipeServiceProtocol
    
    init(navigationController: UINavigationController, service: RecipeServiceProtocol) {
        self.navigationController = navigationController
        self.service = service
    }
    
    func start() {
        let rootController = HomeViewController(service: service, delegate: self)
        rootController.title = "Home"
        navigationController.pushViewController(rootController, animated: false)
    }
    
}

extension AppCoordinator: HomeViewControllerDelegate {
    func didTapRecipe(recipe: Recipe) {
        let detailViewController = RecipeDetailViewController(
            recipe: recipe,
            service: service,
            delegate: self
        )
        detailViewController.title = "Recipe Details"
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension AppCoordinator: RecipeDetailViewControllerDelegate {
    func didTap(url: URL) {
        let safariController = SFSafariViewController(url: url)
        safariController.modalPresentationStyle = .formSheet
        navigationController.viewControllers.first?.present(safariController, animated: true)
    }
}
