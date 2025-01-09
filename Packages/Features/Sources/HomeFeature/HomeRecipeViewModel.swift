//
//  HomeRecipeViewModel.swift
//  Features
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import Networking
import SwiftUI

@MainActor
public final class HomeRecipeViewModel: ObservableObject {
    
    public enum ViewState: Sendable {
        case initial, loading, loaded, emptyList, error
    }
    
    @Published public var state = ViewState.initial
    @Published public var recipeCategories = [RecipeCategory]()
    @Published public var viewError: Error?
    
    let service: RecipeServiceProtocol
    
    public init(service: RecipeServiceProtocol) {
        self.service = service
    }
    
    public func fetchRecipes() async {
        state = .loading
        recipeCategories = []
        viewError = nil
        
        do {
            recipeCategories = try await service.fetchRecipes()
            withAnimation { state = recipeCategories.isEmpty ? .emptyList : .loaded }
        } catch {
            recipeCategories = []
            viewError = error
            withAnimation { state = .error }
        }
    }
}
