//
//  HomeRecipeView.swift
//  Features
//
//  Created by Javier Munoz on 1/8/25.
//

import Components
import Models
import Networking
import SwiftUI

public protocol HomeRecipeViewDelegate: AnyObject {
    @MainActor func didTapRecipe(recipe: Recipe)
}

public struct HomeRecipeView: View {
    @ObservedObject private var viewModel: HomeRecipeViewModel
    public weak var delegate: HomeRecipeViewDelegate?
    
    public init(viewModel: HomeRecipeViewModel, delegate: HomeRecipeViewDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    public var body: some View {
        ScrollView {
            switch viewModel.state {
            case .initial, .loading:
                loadingView
            case .loaded:
                recipeView
            case .emptyList:
                emptyListView
            case .error:
                EmptyView()
            }
        }
        .task {
            if viewModel.state == .initial {
                await viewModel.fetchRecipes()
            }
        }
        .refreshable {
            await viewModel.fetchRecipes()
        }
        .overlay {
            if let error = viewModel.viewError {
                ContentUnavailableView(
                    error.localizedDescription,
                    systemImage: "exclamationmark.triangle.fill",
                    description: Text("Refresh to try again")
                )
                .padding(.top, 50)
            }
        }
    }
    
    var loadingView: some View {
        VStack {
            RecipeCategoryView(category: RecipeCategory.mock, service: viewModel.service, onTap: { _ in })
        }
        .redacted(reason: .placeholder)
    }
    
    var recipeView: some View {
        VStack {
            ForEach(viewModel.recipeCategories) { category in
                RecipeCategoryView(category: category, service: viewModel.service) { recipe in
                    delegate?.didTapRecipe(recipe: recipe)
                }
            }
        }
    }
    
    var emptyListView: some View {
        ContentUnavailableView(
            "There are currently no recipes to view",
            systemImage: "arrow.trianglehead.clockwise.rotate.90",
            description: Text("Pull to refresh")
        )
        .padding(.top, 50)
    }
}

#Preview {
    HomeRecipeView(viewModel: .init(service: MockRecipeService(dataSource: .valid)))
}
