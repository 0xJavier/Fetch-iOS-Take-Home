//
//  RecipeServiceProtocol.swift
//  Networking
//
//  Created by Javier Munoz on 1/8/25.
//

import Models
import UIKit

public protocol RecipeServiceProtocol {
    @MainActor var imageCache: NSCache<NSString, UIImage> { get }
    @MainActor func fetchRecipes() async throws -> [RecipeCategory]
    @MainActor func fetchImage(from url: String) async throws -> UIImage?
}

public enum RecipeServiceError: Error, LocalizedError {
    case invalidURLString
    case invalidData
    case invalidResponse
    
    public var errorDescription: String? {
        switch self {
        case .invalidURLString:
            return  "Unable to create URL from provided string"
        case .invalidData:
            return "Unable to decode data from response"
        case .invalidResponse:
            return "Unable to get response from network"
        }
    }
}
