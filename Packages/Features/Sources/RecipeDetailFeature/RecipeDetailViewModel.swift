//
//  RecipeDetailViewModel.swift
//  Features
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import Networking
import SwiftUI

@MainActor
public final class RecipeDetailViewModel: ObservableObject {
    let recipe: Recipe
    let service: RecipeServiceProtocol
    
    @Published var image: UIImage?
    
    var imageURL: URL? {
        guard let imageURL = recipe.photoUrlLarge else { return nil }
        return URL(string: imageURL)
    }
    
    var sourceURL: URL? {
        guard let sourceURL = recipe.sourceUrl else { return nil }
        return URL(string: sourceURL)
    }
    
    var youtubeURL: URL? {
        guard let youtubeURL = recipe.youtubeUrl else { return nil }
        return URL(string: youtubeURL)
    }
    
    public init(recipe: Recipe, service: RecipeServiceProtocol) {
        self.recipe = recipe
        self.service = service
        self.image = image
    }
    
    public func setImage() async {
        if let imageURL = recipe.photoUrlLarge {
            image = try? await service.fetchImage(from: imageURL)
        }
    }
}
