//
//  RecipesListViewModel.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

@MainActor
protocol RecipesListViewModel {
    // MARK: - OUTPUTS
    var didLoadRecipes: (([RecipesItem])-> Void)? { get set }
    var didToggleSearchEmptyResultView: ((Bool) -> Void)? { get set }
    var didTogleLoadView: ((Bool) -> Void)? { get set }
    var didErrorResult: (()->Void)? { get set }
    
    // MARK: - INPUTS
    func getRecipes() async
    func handleDidTapRecipe(index: Int)
    func searchRecipes(query: String)
}

class RecipesListViewModelDefault: RecipesListViewModel {
    var didLoadRecipes: (([RecipesItem])-> Void)?
    var didToggleSearchEmptyResultView: ((Bool) -> Void)?
    var didTogleLoadView: ((Bool) -> Void)?
    var didErrorResult: (()->Void)?
    
    private var recipes: [Recipe] = []

    private var recipesItems: [RecipesItem]  {
         recipes.map { RecipesItem(viewModel:  RecipeCellViewModelDefault(recipe: $0))}
    }

    private var coordinator: RecipeListCoordinatorDelegate?
    private let getRecipeAction: GetRecipesAction
    
    init(getRecipeAction: GetRecipesAction, coordinator: RecipeListCoordinatorDelegate?) {
        self.getRecipeAction = getRecipeAction
        self.coordinator = coordinator
    }

    func getRecipes() async {
        didTogleLoadView?(true)
        do {
            recipes = try await getRecipeAction.execute()
            didLoadRecipes?(recipesItems)
            didTogleLoadView?(false)
        } catch {
            didErrorResult?()
        }
    }

    func handleDidTapRecipe(index: Int) {
        let recipe = recipes[index]
        coordinator?.handleDidTapRecipe(recipe)
    }
    
    func searchRecipes(query: String) {
        guard !query.isEmpty else {
            didLoadRecipes?(recipesItems)
            didToggleSearchEmptyResultView?(false)
            return
        }
        let searchRecipeResults = recipes.filter { $0.matchesQuery(query) }
                                        .map { RecipesItem(viewModel:  RecipeCellViewModelDefault(recipe: $0)) }
        didLoadRecipes?(searchRecipeResults)
        didToggleSearchEmptyResultView?(searchRecipeResults.isEmpty)
    }
}
