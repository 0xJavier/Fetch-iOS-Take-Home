//
//  RecipeItemViewModel.swift
//  Components
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import Networking
import SwiftUI

@MainActor
public final class RecipeItemViewModel: ObservableObject {
    let recipe: Recipe
    let service: RecipeServiceProtocol
    
    @Published var image: UIImage?
    
    public init(recipe: Recipe, service: RecipeServiceProtocol) {
        self.recipe = recipe
        self.service = service
    }
    
    public func setImage() async {
        if let imageURL = recipe.photoUrlLarge {
            image = try? await service.fetchImage(from: imageURL)
        }
    }
}
