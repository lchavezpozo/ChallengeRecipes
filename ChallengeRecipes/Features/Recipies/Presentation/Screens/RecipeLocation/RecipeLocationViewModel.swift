//
//  RecipeLocationViewModel.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 11/02/25.
//

import CoreLocation

@MainActor
protocol RecipeLocationViewModel {
    var recipeTitle: String { get }
    var recipeLocation: CLLocationCoordinate2D { get }
}

struct RecipeLocationViewModelDefault: RecipeLocationViewModel {
    var recipeTitle: String {
        return recipe.name
    }

    var recipeLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: recipe.origin.latitude,
                               longitude: recipe.origin.longitude)
    }

    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
