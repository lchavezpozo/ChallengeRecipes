//
//  RecipeService.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

protocol RecipeService: Sendable {
    func getRecipes() async throws -> [Recipe]
}
