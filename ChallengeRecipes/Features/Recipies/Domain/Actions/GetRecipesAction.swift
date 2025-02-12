//
//  GetRecipesAction.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

protocol GetRecipesAction {
    func execute() async throws -> [Recipe]
}

struct GetRecipesActionDefault: GetRecipesAction {
    private let recipeService: RecipeService

    init(recipeService: RecipeService) {
        self.recipeService = recipeService
    }

    func execute() async throws -> [Recipe] {
        try await recipeService.getRecipes()
    }
}
