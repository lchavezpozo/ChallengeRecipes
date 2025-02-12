//
//  InfraestructureProvider.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 11/02/25.
//

struct InfrastructureProvider {
    static func getRecipeService(httpClient: HTTPClient) -> RecipeService {
        return RecipeServiceDefault(client: httpClient)
    }
}
