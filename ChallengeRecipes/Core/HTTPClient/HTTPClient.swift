//
//  HTTPClient.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

import Foundation

protocol HTTPClient: Sendable {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

struct URLSessionHTTPClient: HTTPClient {
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let url = endpoint.url(baseURL: baseURL)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
