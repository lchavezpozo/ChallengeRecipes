//
//  Recipe.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

struct Recipe {
    let imageName: String
    let name: String
    let description: String
    let ingredients: [String]
    let preparation: [String]
    let origin: Location

    func matchesQuery(_ query: String) -> Bool {
        let lowercasedQuery = query.lowercased()
        return name.lowercased().contains(lowercasedQuery) ||
        ingredients.contains { $0.lowercased().contains(lowercasedQuery) }
    }
}
