//
//  HTTPClientMock.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 12/02/25.
//

@testable import ChallengeRecipes

class HTTPClientMock: HTTPClient, @unchecked Sendable {
    var invokedRequest = false
    var invokedRequestCount = 0
    var invokedRequestParameters: Endpoint?
    var stubbedRequestResult: Any?
    var stubbedRequestError: Error?

    func request<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable {
        invokedRequest = true
        invokedRequestCount += 1
        invokedRequestParameters = endpoint
        if let error = stubbedRequestError {
            throw error
        }
        guard let result = stubbedRequestResult as? T else {
            fatalError("Stubbed result type mismatch or not set.")
        }
        return result
    }
}
