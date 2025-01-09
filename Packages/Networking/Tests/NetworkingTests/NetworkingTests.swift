import Foundation
import Testing
@testable import Networking

struct RecipeServiceTests {
    @Test
    func testFetchRecipes_GivenValidData_ReturnsRecipes() async throws {
        let service = MockRecipeService(dataSource: .valid)
        let response = try await service.fetchRecipes()
        #expect(!response.isEmpty)
    }
    
    @Test
    func testFetchRecipes_GivenEmptyData_ReturnsEmptyList() async throws {
        let service = MockRecipeService(dataSource: .empty)
        let response = try await service.fetchRecipes()
        #expect(response.isEmpty)
    }
    
    @Test
    func testFetchRecipes_GivenInvalidData_ThrowsError() async throws {
        await #expect(performing: {
            let service = MockRecipeService(dataSource: .invalid)
            let _ = try await service.fetchRecipes()
        }, throws: { error in
            (error as? RecipeServiceError) == .invalidData
        })
    }
}
