//
//  RecipeDetailViewController.swift
//  Features
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import Networking
import SwiftUI

public protocol RecipeDetailViewControllerDelegate: AnyObject {
    @MainActor func didTap(url: URL)
}

public final class RecipeDetailViewController: UIViewController, RecipeDetailViewDelegate {
    let recipe: Recipe
    let service: RecipeServiceProtocol
    let delegate: RecipeDetailViewControllerDelegate?
    
    public init(
        recipe: Recipe,
        service: RecipeServiceProtocol,
        delegate: RecipeDetailViewControllerDelegate? = nil
    ) {
        self.recipe = recipe
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
            rootView: RecipeDetailView(
                viewModel: .init(recipe: recipe, service: service),
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
    
    public func didTap(url: URL) {
        delegate?.didTap(url: url)
    }
}
