//
//  GetRecipesActionTests.swift
//  ChallengeRecipesTests
//
//  Created by Luis Chavez pozo on 12/02/25.
//

import XCTest
@testable import ChallengeRecipes

final class GetRecipesActionDefaultTests: XCTestCase {
    private var sut: GetRecipesActionDefault!
    private var recipeService: RecipeServiceMock!
    private var recipesResults: [Recipe]?

    func test_execute_serviceSuccess() async throws {
        givenSUT()
        givenRecipesServiceSuccess()
        try await whenExecute()
        XCTAssertFalse(recipesResults?.isEmpty ?? true)
        XCTAssertTrue(recipeService.invokedGetRecipes)
    }

    func test_execute_serviceFailure() async throws {
        givenSUT()
        givenRecipesServiceFailure()
        do {
            try await whenExecute()
            XCTFail("An error was expected, but the execution was successful.")
        } catch {
            XCTAssertTrue(recipeService.invokedGetRecipes)
        }
    }
}

private extension GetRecipesActionDefaultTests {
    func givenSUT() {
        recipeService = RecipeServiceMock()
        sut = GetRecipesActionDefault(recipeService: recipeService)
    }

    func givenRecipesServiceSuccess() {
        recipeService.stubbedGetRecipesResult = .success(RecipeMother.ramdomRecipes())
    }
    
    func givenRecipesServiceFailure() {
        let someError = NSError(domain: "Test", code: 0)
        recipeService.stubbedGetRecipesResult = .failure(someError)
    }

    func whenExecute() async throws {
        recipesResults = try await sut.execute()
    }
}
