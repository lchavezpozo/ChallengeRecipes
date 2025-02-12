//
//  RecipeDTOTests.swift
//  ChallengeRecipesTests
//
//  Created by Luis Chavez pozo on 12/02/25.
//

import XCTest
@testable import ChallengeRecipes

final class RecipeDTOTests: XCTestCase {
    func test_recipeDTO_decoding() throws {
        // Given
        let json = """
        {
            "imageName": "recipeImage.png",
            "name": "Delicious Cake",
            "description": "A very delicious and spongy cake.",
            "ingredients": ["Flour", "Eggs", "Sugar", "Butter"],
            "preparation": ["Mix ingredients", "Bake for 30 minutes"],
            "origin": {
                "latitude": 37.7749,
                "longitude": -122.4194
            }
        }
        """.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        let recipeDTO = try decoder.decode(RecipeDTO.self, from: json)

        // Then
        XCTAssertEqual(recipeDTO.imageName, "recipeImage.png")
        XCTAssertEqual(recipeDTO.name, "Delicious Cake")
        XCTAssertEqual(recipeDTO.description, "A very delicious and spongy cake.")
        XCTAssertEqual(recipeDTO.ingredients, ["Flour", "Eggs", "Sugar", "Butter"])
        XCTAssertEqual(recipeDTO.preparation, ["Mix ingredients", "Bake for 30 minutes"])
        XCTAssertEqual(recipeDTO.origin.latitude, 37.7749)
        XCTAssertEqual(recipeDTO.origin.longitude, -122.4194)
    }
    
    func test_recipeDTO_toModel() throws {
        // Given
        let locationDTO = LocationDTO(latitude: 37.7749, longitude: -122.4194)
        let recipeDTO = RecipeDTO(
            imageName: "recipeImage.png",
            name: "Delicious Cake",
            description: "A very delicious and spongy cake.",
            ingredients: ["Flour", "Eggs", "Sugar", "Butter"],
            preparation: ["Mix ingredients", "Bake for 30 minutes"],
            origin: locationDTO
        )
        
        // When
        let recipeModel = recipeDTO.toModel()
        
        // Then
        XCTAssertEqual(recipeModel.imageName, "recipeImage.png")
        XCTAssertEqual(recipeModel.name, "Delicious Cake")
        XCTAssertEqual(recipeModel.description, "A very delicious and spongy cake.")
        XCTAssertEqual(recipeModel.ingredients, ["Flour", "Eggs", "Sugar", "Butter"])
        XCTAssertEqual(recipeModel.preparation, ["Mix ingredients", "Bake for 30 minutes"])
        XCTAssertEqual(recipeModel.origin.latitude, 37.7749)
        XCTAssertEqual(recipeModel.origin.longitude, -122.4194)
    }
}
