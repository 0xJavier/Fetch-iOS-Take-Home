//
//  RecipeItemView.swift
//  Components
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import Networking
import SwiftUI

struct RecipeItemView: View {
    @ObservedObject private var viewModel: RecipeItemViewModel
    
    public init(viewModel: RecipeItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            recipeImageView
            
            Text(viewModel.recipe.name)
                .font(.headline)
                .fontDesign(.rounded)
                .lineLimit(2)
        }
        .frame(width: 175)
        .task {
            if viewModel.image == nil {
                await viewModel.setImage()
            }
        }
    }
    
    @ViewBuilder
    var recipeImageView: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 175 ,height: 200)
                .clipShape(.rect(cornerRadius: 10))
        } else {
            placeholderView
        }
    }
    
    var placeholderView: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 175 ,height: 200)
            .foregroundStyle(Color(uiColor: .secondarySystemBackground).gradient)
    }
}

#Preview {
    RecipeItemView(
        viewModel: RecipeItemViewModel(
            recipe: Recipe.generateMock(),
            service: MockRecipeService()
        )
    )
}
