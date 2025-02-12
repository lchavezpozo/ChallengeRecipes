//
//  RecipeCellViewModel.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

@MainActor
protocol RecipeCellViewModel {
    var imangeName: String { get }
    var name: String { get }
}

struct RecipeCellViewModelDefault: RecipeCellViewModel {
    var imangeName: String {
        recipe.imageName
    }
    
    var name: String {
        recipe.name
    }

    private let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
