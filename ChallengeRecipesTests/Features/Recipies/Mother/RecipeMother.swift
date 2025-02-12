//
//  RecipeMother.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 12/02/25.
//

@testable import ChallengeRecipes

struct RecipeMother {
    static func ramdomRecipe() -> Recipe {
        Recipe(imageName: "test",
                       name: "test",
                       description: "test",
                       ingredients: [],
                       preparation: [],
                       origin: .init(latitude: 0, longitude: 0))
    }
    static func ramdomRecipes() -> [Recipe] {
        return [RecipeMother.ramdomRecipe(),
                RecipeMother.ramdomRecipe()]
    }
}


struct RecipeDTOMother {
    static func randomRecipeDTO() -> RecipeDTO {
        return RecipeDTO(imageName: "test",
                         name: "test",
                         description: "test",
                         ingredients: [],
                         preparation: [],
                         origin: .init(latitude: 0, longitude: 0))
    }
    
    static func randomRecipeDTOs() -> [RecipeDTO] {
        return [RecipeDTOMother.randomRecipeDTO(),
                RecipeDTOMother.randomRecipeDTO()]
    }
}
