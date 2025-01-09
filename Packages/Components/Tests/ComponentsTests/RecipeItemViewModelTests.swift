import Models
import Networking
import Testing
@testable import Components

struct RecipeItemViewModelTests {
    @Test
    func testRecipeItemViewModel_GivenDependencies_ReturnsValidViewModel() async throws {
        let mockRecipe = Recipe.generateMock()
        let mockService = MockRecipeService()
        let viewModel = await RecipeItemViewModel(recipe: mockRecipe, service: mockService)
        await #expect(viewModel.recipe == mockRecipe)
        await #expect(viewModel.image == nil)
    }

    @Test
    func testRecipeItemViewModel_GivenDependencies_FetchesAndSetsImage() async throws {
        let mockRecipe = Recipe.generateMock()
        let mockService = MockRecipeService()
        let viewModel = await RecipeItemViewModel(recipe: mockRecipe, service: mockService)
        await #expect(viewModel.image == nil)
        await viewModel.setImage()
        await #expect(viewModel.image != nil)
    }
}
