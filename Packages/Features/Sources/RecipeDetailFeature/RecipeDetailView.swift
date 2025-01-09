//
//  File.swift
//  Features
//
//  Created by Javier Munoz on 1/8/25.
//

import Components
import Models
import Networking
import SwiftUI

public protocol RecipeDetailViewDelegate: AnyObject {
    @MainActor func didTap(url: URL)
}

public struct RecipeDetailView: View {
    @ObservedObject private var viewModel: RecipeDetailViewModel
    weak var delegate: RecipeDetailViewDelegate?
    
    public init(viewModel: RecipeDetailViewModel, delegate: RecipeDetailViewDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } else {
                Rectangle()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(uiColor: .secondarySystemBackground).gradient)
            }
            
            Group {
                Text(viewModel.recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("\(viewModel.recipe.cuisine) Cuisine")
                    .font(.title)
            }
            .fontDesign(.rounded)
            .padding([.top, .leading])
            
            
            Spacer()
            
            if let sourceURL = viewModel.sourceURL {
                RecipeButtonView(title: "Learn how to make") {
                    delegate?.didTap(url: sourceURL)
                }
                .padding()
            }
            
            if let youtubeURL = viewModel.youtubeURL {
                RecipeButtonView(title: "Watch on YouTube", tintColor: .red) {
                    delegate?.didTap(url: youtubeURL)
                }
                .padding()
            }
        }
        .task {
            if viewModel.image == nil {
                await viewModel.setImage()
            }
        }
    }
}

#Preview {
    RecipeDetailView(viewModel: .init(recipe: .generateMock(), service: MockRecipeService()))
}
