//
//  SceneDelegate.swift
//  FetchRecipe
//
//  Created by Javier Munoz on 1/8/25.
//

import Networking
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let rootNavigationController = UINavigationController()
    let recipeService: RecipeServiceProtocol = LiveRecipeService()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let appCoordinator = AppCoordinator(
            navigationController: rootNavigationController,
            service: recipeService
        )
        
        appCoordinator.start()
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = rootNavigationController
        self.window?.makeKeyAndVisible()
    }

}
