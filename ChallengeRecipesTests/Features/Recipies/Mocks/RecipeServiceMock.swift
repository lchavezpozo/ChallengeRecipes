//
//  RecipeServiceMock.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 12/02/25.
//
@testable import ChallengeRecipes

class RecipeServiceMock: RecipeService, @unchecked Sendable {
    var invokedGetRecipes = false
    var invokedGetRecipesCount = 0
    var stubbedGetRecipesResult: Result<[Recipe], Error>!

    func getRecipes() async throws -> [Recipe] {
        invokedGetRecipes = true
        invokedGetRecipesCount += 1

        switch stubbedGetRecipesResult {
        case .success(let recipes):
            return recipes
        case .failure(let error):
            throw error
        case .none:
            return []
        }
    }
}
