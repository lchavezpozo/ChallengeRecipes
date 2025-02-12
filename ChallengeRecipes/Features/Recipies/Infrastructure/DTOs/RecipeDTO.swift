//
//  RecipeDTO.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

struct RecipeDTO: Decodable {
    let imageName: String
    let name: String
    let description: String
    let ingredients: [String]
    let preparation: [String]
    let origin: LocationDTO

    func toModel() -> Recipe {
        return Recipe(
            imageName: imageName,
            name: name,
            description: description,
            ingredients: ingredients,
            preparation: preparation,
            origin: origin.toModel()
        )
    }
}
