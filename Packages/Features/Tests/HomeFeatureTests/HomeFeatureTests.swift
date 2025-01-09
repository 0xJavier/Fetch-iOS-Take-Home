import Networking
import Testing
@testable import HomeFeature

struct HomeFeatureTests {
    @Test
    func testHomeViewModel_GivenDependencies_InitializesWithExpectedState() async throws {
        let service: RecipeServiceProtocol = MockRecipeService()
        let viewModel = await HomeRecipeViewModel(service: service)
        await #expect(viewModel.state == .initial)
        await #expect(viewModel.recipeCategories.isEmpty)
        await #expect(viewModel.viewError == nil)
    }
    
    @Test
    func testFetchRecipes_GivenValidResponse_SetsViewModelProperties() async throws {
        let service: RecipeServiceProtocol = MockRecipeService()
        let viewModel = await HomeRecipeViewModel(service: service)
        await viewModel.fetchRecipes()
        await #expect(viewModel.state == .loaded)
        await #expect(!viewModel.recipeCategories.isEmpty)
        await #expect(viewModel.viewError == nil)
    }
    
    @Test
    func testFetchRecipes_GivenInvalidResponse_SetsViewModelProperties() async throws {
        let service: RecipeServiceProtocol = MockRecipeService(dataSource: .invalid)
        let viewModel = await HomeRecipeViewModel(service: service)
        await viewModel.fetchRecipes()
        await #expect(viewModel.state == .error)
        await #expect(viewModel.recipeCategories.isEmpty)
        await #expect(viewModel.viewError != nil)
    }
}
