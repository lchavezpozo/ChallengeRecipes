//
//  RecipesListViewModelTests.swift
//  ChallengeRecipesTests
//
//  Created by Luis Chavez pozo on 12/02/25.
//

import XCTest
@testable import ChallengeRecipes

@MainActor
final class RecipesListViewModelTests: XCTestCase {
    private var sut: RecipesListViewModelDefault!
    private var coordinatorSpy: RecipeListCoordinatorDelegateMock!
    private var getRecipeAction: GetRecipesActionMock!
    private var capturedRecipes: [RecipesItem]!
    private var capturedIsLoading: Bool!
    private var isErrorShown = false

    func test_getRecipes_successfulLoad() async {
        givenSUT()
        givenGetRecipesActionSuccess()
        
        await whenGetRecipes()
        
        XCTAssertFalse(capturedRecipes.isEmpty)
        XCTAssertFalse(capturedIsLoading)
        XCTAssertTrue(getRecipeAction.invokedExecute)
        XCTAssertEqual(capturedRecipes.count, 2)
    }

    func test_getRecipes_failureLoad() async {
        givenSUT()
        givenGetRecipesActionFailure()

        await whenGetRecipes()
        
        XCTAssertTrue(isErrorShown)
        XCTAssertTrue(getRecipeAction.invokedExecute)
    }

    func test_searchRecipes_withMatch() async {
        givenSUT()
        givenGetRecipesActionSuccess()
        await whenGetRecipes()
        let query = "chocolate"
        whenSearchRecipes(query: query)
        
        XCTAssertFalse(capturedRecipes.isEmpty)
        XCTAssertEqual(capturedRecipes.count, 1)
    }

    func test_searchRecipes_noMatch() async {
        givenSUT()
        givenGetRecipesActionSuccess()
        await whenGetRecipes()
        let query = "sweets"
        whenSearchRecipes(query: query)
        
        XCTAssertTrue(capturedRecipes.isEmpty)
    }

    func test_handleDidTapRecipe_callsCoordinator() async {
        givenSUT()
        givenGetRecipesActionSuccess()
        await whenGetRecipes()
        sut.handleDidTapRecipe(index: 0)
        XCTAssertTrue(coordinatorSpy.invokedHandleDidTapRecipe)
        XCTAssertNotNil(coordinatorSpy.invokedHandleDidTapRecipeParameters)
     }
}

private extension RecipesListViewModelTests {
    func givenSUT() {
        getRecipeAction = GetRecipesActionMock()
        coordinatorSpy = RecipeListCoordinatorDelegateMock()
        sut = RecipesListViewModelDefault(getRecipeAction: getRecipeAction, coordinator: coordinatorSpy)
        
        sut.didLoadRecipes = { [weak self] recipes in
            self?.capturedRecipes = recipes
        }
        sut.didTogleLoadView = { [weak self] isLoading in
            self?.capturedIsLoading = isLoading
        }
        sut.didErrorResult = { [weak self] in
            self?.isErrorShown = true
        }
    }

    func givenGetRecipesActionSuccess() {
        let chocolateCake = Recipe(
            imageName: "example.jpg",
            name: "Chocolate Cake",
            description: "Delicious chocolate cake",
            ingredients: ["Flour", "Sugar", "Cocoa Powder", "Eggs"],
            preparation: ["Mix ingredients", "Bake"],
            origin: .init(latitude: 0, longitude: 0)
        )
        let vanillaCake = Recipe(
            imageName: "example.jpg",
            name: "Vanilla Cake",
            description: "Delicious vanilla cake",
            ingredients: ["Flour", "Sugar", "Vanilla Extract", "Eggs"],
            preparation: ["Mix ingredients", "Bake"],
            origin: .init(latitude: 0, longitude: 0)
        )
        getRecipeAction.stubbedExecuteResult = .success([chocolateCake, vanillaCake])
    }

    func givenGetRecipesActionFailure() {
        let someError = NSError(domain: "Test", code: 0)
        getRecipeAction.stubbedExecuteResult = .failure(someError)
    }

    func whenGetRecipes() async {
        await sut.getRecipes()
    }
    
    func whenSearchRecipes(query: String) {
        sut.searchRecipes(query: query)
    }
}
