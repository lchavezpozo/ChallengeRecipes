//
//  RecipesListViewModelMock.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 12/02/25.
//

@testable import ChallengeRecipes

class RecipesListViewModelMock: RecipesListViewModel {
    var didLoadRecipes: (([RecipesItem]) -> Void)?
    var didToggleSearchEmptyResultView: ((Bool) -> Void)?
    var didTogleLoadView: ((Bool) -> Void)?
    var didErrorResult: (() -> Void)?
    
    var invokedGetRecipes = false
    var invokedGetRecipesCount = 0
    
    func getRecipes() async {
        invokedGetRecipes = true
        invokedGetRecipesCount += 1
    }
    
    var invokedHandleDidTapRecipe = false
    var invokedHandleDidTapRecipeIndex: Int?
    
    func handleDidTapRecipe(index: Int) {
        invokedHandleDidTapRecipe = true
        invokedHandleDidTapRecipeIndex = index
    }
    
    var invokedSearchRecipes = false
    var invokedSearchRecipesQuery: String?
    
    func searchRecipes(query: String) {
        invokedSearchRecipes = true
        invokedSearchRecipesQuery = query
    }
}
