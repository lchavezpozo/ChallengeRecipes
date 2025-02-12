//
//  RecipeServiceDefault.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

struct RecipeServiceDefault: RecipeService {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }

    func getRecipes() async throws -> [Recipe] {
        let endpoint = Endpoint(path: "recipes", method: .get, queryItems: nil)
        do {
            let response: RecipeResponseDTO = try await client.request(endpoint)
            return response.toModel()
        } catch {
            throw error
        }
    }
}
