//
//  HomeViewController.swift
//  Features
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import Networking
import SwiftUI

public protocol HomeViewControllerDelegate: AnyObject {
    @MainActor func didTapRecipe(recipe: Recipe)
}

public final class HomeViewController: UIViewController, HomeRecipeViewDelegate {
    
    let service: RecipeServiceProtocol
    let delegate: HomeViewControllerDelegate?
    
    public init(service: RecipeServiceProtocol, delegate: HomeViewControllerDelegate? = nil) {
        self.service = service
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHostingView()
    }
    
    private func configureHostingView() {
        let hostingController = UIHostingController(
            rootView: HomeRecipeView(
                viewModel: HomeRecipeViewModel(service: service),
                delegate: self
            )
        )
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    public func didTapRecipe(recipe: Recipe) {
        self.delegate?.didTapRecipe(recipe: recipe)
    }
    
}

#Preview {
    UINavigationController(rootViewController: HomeViewController(service: LiveRecipeService()))
}
