//
//  RecipeResponseDTOTests.swift
//  ChallengeRecipesTests
//
//  Created by Luis Chavez pozo on 12/02/25.
//

import XCTest
@testable import ChallengeRecipes

final class RecipeResponseDTOTests: XCTestCase {
    func test_recipeResponseDTO_decoding() throws {
        // Given
        let json = """
        {
            "recipes": [
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
                },
                {
                    "imageName": "recipeImage2.png",
                    "name": "Yummy Pie",
                    "description": "A tasty and flaky pie.",
                    "ingredients": ["Apples", "Sugar", "Butter"],
                    "preparation": ["Prepare crust", "Add filling", "Bake for 45 minutes"],
                    "origin": {
                        "latitude": 40.7128,
                        "longitude": -74.0060
                    }
                }
            ]
        }
        """.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        let recipeResponseDTO = try decoder.decode(RecipeResponseDTO.self, from: json)

        // Then
        XCTAssertEqual(recipeResponseDTO.recipes.count, 2)
        XCTAssertEqual(recipeResponseDTO.recipes[0].name, "Delicious Cake")
        XCTAssertEqual(recipeResponseDTO.recipes[1].name, "Yummy Pie")
    }
    
    func test_recipeResponseDTO_toModel() throws {
        // Given
        let locationDTO1 = LocationDTO(latitude: 37.7749, longitude: -122.4194)
        let recipeDTO1 = RecipeDTO(
            imageName: "recipeImage.png",
            name: "Delicious Cake",
            description: "A very delicious and spongy cake.",
            ingredients: ["Flour", "Eggs", "Sugar", "Butter"],
            preparation: ["Mix ingredients", "Bake for 30 minutes"],
            origin: locationDTO1
        )
        
        let locationDTO2 = LocationDTO(latitude: 40.7128, longitude: -74.0060)
        let recipeDTO2 = RecipeDTO(
            imageName: "recipeImage2.png",
            name: "Yummy Pie",
            description: "A tasty and flaky pie.",
            ingredients: ["Apples", "Sugar", "Butter"],
            preparation: ["Prepare crust", "Add filling", "Bake for 45 minutes"],
            origin: locationDTO2
        )
        
        let responseDTO = RecipeResponseDTO(recipes: [recipeDTO1, recipeDTO2])
        
        // When
        let recipeModels = responseDTO.toModel()

        // Then
        XCTAssertEqual(recipeModels.count, 2)
        XCTAssertEqual(recipeModels[0].name, "Delicious Cake")
        XCTAssertEqual(recipeModels[0].origin.latitude, 37.7749)
        XCTAssertEqual(recipeModels[1].name, "Yummy Pie")
        XCTAssertEqual(recipeModels[1].origin.longitude, -74.0060)
    }
}
