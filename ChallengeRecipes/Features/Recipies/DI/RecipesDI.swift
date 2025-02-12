//
//  RecipesDI.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 11/02/25.
//
import Foundation

struct RecipesDI {
    static func makeGetRecipesAction() -> GetRecipesAction {
        let client = URLSessionHTTPClient(baseURL: URL(string: "https://demo8042875.mockable.io/")!)
        let service = RecipeServiceDefault(client: client)
        return GetRecipesActionDefault(recipeService: service)
    }
}
