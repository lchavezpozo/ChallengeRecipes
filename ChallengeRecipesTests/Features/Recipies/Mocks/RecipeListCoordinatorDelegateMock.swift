//
//  RecipeListCoordinatorDelegateMock.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 12/02/25.
//
@testable import ChallengeRecipes

class RecipeListCoordinatorDelegateMock: RecipeListCoordinatorDelegate {
    var invokedHandleDidTapRecipe = false
    var invokedHandleDidTapRecipeCount = 0
    var invokedHandleDidTapRecipeParameters: Recipe?
    
    func handleDidTapRecipe(_ recipe: Recipe) {
        invokedHandleDidTapRecipe = true
        invokedHandleDidTapRecipeCount += 1
        invokedHandleDidTapRecipeParameters = recipe
    }
}
