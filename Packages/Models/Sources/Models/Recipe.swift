//
//  Recipe.swift
//  Models
//
//  Created by Javier Munoz on 1/8/25.
//

import Foundation

public struct RecipeResponse: Codable {
    public let recipes: [Recipe]
}

public struct Recipe: Codable, Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    public let cuisine: String
    public let name: String
    public let photoUrlSmall: String?
    public let photoUrlLarge: String?
    public let sourceUrl: String?
    public let youtubeUrl: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine, name, photoUrlSmall, photoUrlLarge, sourceUrl, youtubeUrl
    }
}

extension Recipe {
    public static func generateMock() -> Recipe {
        Recipe(
            id: UUID().uuidString,
            cuisine: "British",
            name: "Classic Christmas Pudding",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/604d020a-967a-40e1-97d2-561de5c66807/small.jpg",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/604d020a-967a-40e1-97d2-561de5c66807/large.jpg",
            sourceUrl: "https://www.bbcgoodfood.com/recipes/classic-christmas-pudding",
            youtubeUrl: "https://www.youtube.com/watch?v=Pb_lJxL1vtk"
        )
    }
}
