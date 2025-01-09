//
//  RecipeCategory.swift
//  Models
//
//  Created by Javier Munoz on 1/8/25.
//

import Foundation

/// Object used to define a section with a title and a list of recipes to show
public struct RecipeCategory: Identifiable, Sendable {
    public let id: String = UUID().uuidString
    public let category: String
    public let recipes: [Recipe]
    
    public init(category: String, recipes: [Recipe]) {
        self.category = category
        self.recipes = recipes
    }
}

extension RecipeCategory {
    public static let mock = RecipeCategory(
        category: "Placeholder",
        recipes: [Recipe.generateMock(), Recipe.generateMock()]
    )
}
