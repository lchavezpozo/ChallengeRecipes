//
//  RecipeTests.swift
//  ChallengeRecipesTests
//
//  Created by Luis Chavez pozo on 12/02/25.
//

import XCTest
@testable import ChallengeRecipes

final class RecipeTests: XCTestCase {
    func test_matchesQuery_withNameMatch() {
        let recipe = Recipe(
            imageName: "example.jpg",
            name: "Chocolate Cake",
            description: "Delicious chocolate cake",
            ingredients: ["Flour", "Sugar", "Cocoa Powder", "Eggs"],
            preparation: ["Mix ingredients", "Bake"],
            origin: .init(latitude: 0, longitude: 0)
        )
        let query = "chocolate"
        XCTAssertTrue(recipe.matchesQuery(query))
    }

    func test_matchesQuery_withIngredientMatch() {
        let recipe = Recipe(
            imageName: "example.jpg",
            name: "Vanilla Cake",
            description: "Delicious vanilla cake",
            ingredients: ["Flour", "Sugar", "Vanilla Extract", "Eggs"],
            preparation: ["Mix ingredients", "Bake"],
            origin: .init(latitude: 0, longitude: 0)
        )
        let query = "vanilla"
        XCTAssertTrue(recipe.matchesQuery(query))
    }

    func test_matchesQuery_withNoMatch() {
        let recipe = Recipe(
            imageName: "example.jpg",
            name: "Strawberry Cake",
            description: "Delicious strawberry cake",
            ingredients: ["Flour", "Sugar", "Strawberries", "Eggs"],
            preparation: ["Mix ingredients", "Bake"],
            origin: .init(latitude: 0, longitude: 0)
        )
        let query = "chocolate"
        XCTAssertFalse(recipe.matchesQuery(query))
    }

    func test_matchesQuery_withCaseInsensitiveMatch() {
        let recipe = Recipe(
            imageName: "example.jpg",
            name: "Apple Pie",
            description: "Delicious apple pie",
            ingredients: ["Flour", "Sugar", "Apples", "Butter"],
            preparation: ["Mix ingredients", "Bake"],
            origin: .init(latitude: 0, longitude: 0)
        )

        let query = "APPLE"
        XCTAssertTrue(recipe.matchesQuery(query))
    }
}
