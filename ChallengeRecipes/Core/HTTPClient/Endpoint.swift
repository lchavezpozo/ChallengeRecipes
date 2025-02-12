//
//  Endpoint.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?
    
    func url(baseURL: URL) -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                       resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        return components?.url ?? baseURL
    }
}
