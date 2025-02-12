//
//  RecipesListViewControllerTests.swift
//  ChallengeRecipesTests
//
//  Created by Luis Chavez pozo on 12/02/25.
//

import XCTest
@testable import ChallengeRecipes

@MainActor
final class RecipesListViewControllerTests: XCTestCase {
    private var sut: RecipesListViewController!
    private var viewModel: RecipesListViewModelMock!
    private var expectedRecipesCount = 0

    func test_loadRecipes_showsDataInCollectionView() {
        givenSUT()
        whenDidLoadRecipes()
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), expectedRecipesCount)
    }

    func test_searchUpdates_triggers_searchRecipes() {
        givenSUT()
        whenUpdateSearchResult()
        XCTAssertTrue(viewModel.invokedSearchRecipes)
    }

    func test_selectRecipe_triggers_handleDidTapRecipe() {
        givenSUT()
        whenCollectionViewDidSelectItem()
        XCTAssertTrue(viewModel.invokedHandleDidTapRecipe)
        XCTAssertEqual(viewModel.invokedHandleDidTapRecipeIndex, 0)
    }
}

private extension RecipesListViewControllerTests {
    func givenSUT() {
        viewModel = RecipesListViewModelMock()
        sut = RecipesListViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        sut.viewDidLoad()
    }
    
    func whenDidLoadRecipes() {
        let recipeCellViewModelDefault = RecipeCellViewModelDefault(recipe: RecipeMother.ramdomRecipe())
        let expectedRecipes = [RecipesItem(viewModel: recipeCellViewModelDefault),
                               RecipesItem(viewModel: recipeCellViewModelDefault)]
        expectedRecipesCount = expectedRecipes.count
        viewModel.didLoadRecipes?(expectedRecipes)
    }
    
    func whenUpdateSearchResult() {
        sut.updateSearchResults(for: UISearchController(searchResultsController: nil))
    }
    
    func whenCollectionViewDidSelectItem() {
        let indexPath = IndexPath(item: 0, section: 0)
        sut.collectionView(sut.collectionView, didSelectItemAt: indexPath)
    }
}
