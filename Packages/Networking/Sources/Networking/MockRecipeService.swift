//
//  MockRecipeService.swift
//  Networking
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import UIKit

public final class MockRecipeService: RecipeServiceProtocol {
    public enum DataSource {
        case valid, invalid, empty
    }
    
    let dataSource: DataSource
    public var imageCache = NSCache<NSString, UIImage>()
    private let decoder = JSONDecoder()
    
    public init(dataSource: DataSource = .valid) {
        self.dataSource = dataSource
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func fetchRecipes() async throws -> [RecipeCategory] {
        let resourceString: String = switch dataSource {
        case .valid: "fetch-valid-response"
        case .invalid: "fetch-invalid-response"
        case .empty: "fetch-empty-response"
        }
        
        guard let url = Bundle.module.url(forResource: resourceString, withExtension: "json") else {
            throw RecipeServiceError.invalidURLString
        }
        
        let response: RecipeResponse
        do {
            let data = try Data(contentsOf: url)
            response = try decoder.decode(RecipeResponse.self, from: data)
        } catch {
            throw RecipeServiceError.invalidData
        }
        
        try await Task.sleep(for: .seconds(3))
        
        let groupedRecipes = Dictionary(grouping: response.recipes, by: \.cuisine)
        return groupedRecipes
            .map { RecipeCategory(category: $0.key, recipes: $0.value) }
            .sorted { $0.category < $1.category }
    }
    
    public func fetchImage(from url: String) async throws -> UIImage? {
        try await Task.sleep(for: .seconds(2))
        
        let cacheKey = NSString(string: url)
        if let image = imageCache.object(forKey: cacheKey) {
            return image
        } else {
            let image = UIImage()
            imageCache.setObject(image, forKey: cacheKey)
            return image
        }
    }
}
