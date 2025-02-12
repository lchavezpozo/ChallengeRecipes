//
//  RecipeServiceDefaultTests.swift
//  ChallengeRecipesTests
//
//  Created by Luis Chavez pozo on 12/02/25.
//

import XCTest
@testable import ChallengeRecipes

final class RecipeServiceDefaultTests: XCTestCase {
    private var sut: RecipeServiceDefault!
    private var httpClient: HTTPClientMock!

    func test_getRecipes_successfulResponse() async throws {
        givenSUT()
        givenHttpClientReturnSuccess()
        try await whenGetRecipes()

        XCTAssertTrue(httpClient.invokedRequest)
        XCTAssertEqual(httpClient.invokedRequestCount, 1)
    }

    func test_getRecipes_throwsError() async throws {
        givenSUT()
        givenHttpClientReturnError()

        do {
            try await whenGetRecipes()
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertTrue(httpClient.invokedRequest)
            XCTAssertEqual(httpClient.invokedRequestCount, 1)
        }
    }
}

private extension RecipeServiceDefaultTests {
    func givenSUT() {
        httpClient = HTTPClientMock()
        sut = RecipeServiceDefault(client: httpClient)
    }

    func givenHttpClientReturnSuccess() {
        let expectedRecipes = RecipeDTOMother.randomRecipeDTOs()
        let responseDTO = RecipeResponseDTO(recipes: RecipeDTOMother.randomRecipeDTOs())
        httpClient.stubbedRequestResult = responseDTO
    }

    func givenHttpClientReturnError() {
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        httpClient.stubbedRequestError = expectedError
    }

    func whenGetRecipes() async throws {
        _ = try await sut.getRecipes()
    }
}

