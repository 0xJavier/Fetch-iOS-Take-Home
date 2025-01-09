import Models
import Networking
import Testing
@testable import RecipeDetailFeature

struct RecipeDetailFeatureTests {
    @Test
    func testRecipeDetailViewModel_GivenDependencies_InitializesWithExpectedState() async throws {
        let service: RecipeServiceProtocol = MockRecipeService()
        let mockRecipe = Recipe.generateMock()
        let viewModel = await RecipeDetailViewModel(recipe: mockRecipe, service: service)
        await #expect(viewModel.recipe == mockRecipe)
        await #expect(viewModel.image == nil)
        await #expect(viewModel.imageURL != nil)
        await #expect(viewModel.sourceURL != nil)
        await #expect(viewModel.youtubeURL != nil)
    }
    
    @Test
    func testRecipeDetailViewModel_GivenDependencies_FetchesAndSetsImage() async throws {
        let mockRecipe = Recipe.generateMock()
        let mockService = MockRecipeService()
        let viewModel = await RecipeDetailViewModel(recipe: mockRecipe, service: mockService)
        await #expect(viewModel.image == nil)
        await viewModel.setImage()
        await #expect(viewModel.image != nil)
    }
}

