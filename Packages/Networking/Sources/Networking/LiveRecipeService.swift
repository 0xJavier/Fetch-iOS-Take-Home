//
//  LiveRecipeService.swift
//  Networking
//
//  Created by Javier Munoz on 1/8/25.
//

import OSLog
import Models
import UIKit

public final class LiveRecipeService: RecipeServiceProtocol {
    public let imageCache = NSCache<NSString, UIImage>()
    private let decoder = JSONDecoder()
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LiveRecipeService.self)
    )
    
    public init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func fetchRecipes() async throws -> [RecipeCategory] {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw RecipeServiceError.invalidURLString
        }
        
        let responseData: Data
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw RecipeServiceError.invalidResponse
            }
            responseData = data
        } catch {
            throw error
        }
        
        let fetchedData: RecipeResponse
        do {
            fetchedData = try decoder.decode(RecipeResponse.self, from: responseData)
        } catch {
            throw RecipeServiceError.invalidData
        }

        let groupedRecipes = Dictionary(grouping: fetchedData.recipes, by: \.cuisine)
        return groupedRecipes
            .map { RecipeCategory(category: $0.key, recipes: $0.value) }
            .sorted { $0.category < $1.category }
    }
    
    // Since the image view starts with placeholder, we don't worry about errors
    public func fetchImage(from url: String) async -> UIImage? {
        let cacheKey = NSString(string: url)
        if let image = imageCache.object(forKey: cacheKey) { return image }
        
        guard let imageURL = URL(string: url) else { return nil }
        
        let imageData: Data
        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            imageData = data
        } catch(let error) {
            Self.logger
                .log(
                    level: .error,
                    "Could not fetch image from URL of \(url). Error: \(error.localizedDescription)"
                )
            return nil
        }
        
        if let image = UIImage(data: imageData) {
            imageCache.setObject(image, forKey: cacheKey)
            return image
        } else {
            return nil
        }
    }
}
