//
//  GetRecipesActionMock.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 12/02/25.
//
@testable import ChallengeRecipes

class GetRecipesActionMock: GetRecipesAction {
    var invokedExecute = false
    var invokedExecuteCount = 0
    var stubbedExecuteResult: Result<[Recipe], Error>!

    func execute() async throws -> [Recipe] {
        invokedExecute = true
        invokedExecuteCount += 1

        switch stubbedExecuteResult {
        case .success(let recipes):
            return recipes
        case .failure(let error):
            throw error
        case .none:
            return []
        }
    }
}
