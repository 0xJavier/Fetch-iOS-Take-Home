//
//  Coordinator.swift
//  FetchRecipe
//
//  Created by Javier Munoz on 1/8/25.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    @MainActor func start()
}
