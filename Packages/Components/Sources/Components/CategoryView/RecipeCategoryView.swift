//
//  RecipeCategoryView.swift
//  Components
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import Networking
import SwiftUI

public struct RecipeCategoryView: View {
    let category: RecipeCategory
    let service: RecipeServiceProtocol
    let onTap: (Recipe) -> Void
    
    public init(category: RecipeCategory, service: RecipeServiceProtocol, onTap: @escaping (Recipe) -> Void) {
        self.category = category
        self.service = service
        self.onTap = onTap
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(category.category)
                .font(.title)
                .bold()
                .fontDesign(.rounded)
                .padding(.leading, 16)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(category.recipes) { recipe in
                        RecipeItemView(viewModel: .init(recipe: recipe, service: service))
                            .onTapGesture { onTap(recipe) }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 16, for: .scrollContent)
        }
    }
}

#Preview {
    RecipeCategoryView(
        category: RecipeCategory.mock,
        service: MockRecipeService(),
        onTap: { _ in }
    )
}
