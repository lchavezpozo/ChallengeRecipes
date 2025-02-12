//
//  RecipeResponseDTO.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

struct RecipeResponseDTO: Decodable {
    let recipes: [RecipeDTO]

    func toModel() -> [Recipe] {
        return recipes.map { $0.toModel() }
    }
}
