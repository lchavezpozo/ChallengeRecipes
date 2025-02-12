//
//  RecipeDetailViewModel.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 11/02/25.
//

@MainActor
protocol RecipeDetailViewModel {
    var recipeImageName: String { get }
    var recipeName: String { get }
    var recipeDescription: String { get }
    var recipeIngredients: String { get }
    var recipePreparation: String { get }

    func handleDidTapMap()
}

struct RecipeDetailViewModelDefault: RecipeDetailViewModel {
    var recipeImageName: String {
        recipe.imageName
    }

    var recipeName: String {
        recipe.name
    }

    var recipeDescription: String {
        recipe.description
    }

    var recipeIngredients: String {
        recipe.ingredients.joined(separator: "\n")
    }

    var recipePreparation: String {
        recipe.preparation.joined(separator: "\n")
    }

    private let recipe: Recipe
    private let coordinator: RecipeDetailCoordinatorDelegate

    init(recipe: Recipe, coordinator: RecipeDetailCoordinatorDelegate) {
        self.recipe = recipe
        self.coordinator = coordinator
    }

    func handleDidTapMap() {
        coordinator.handleDidTapOrigin(recipe)
    }
}
