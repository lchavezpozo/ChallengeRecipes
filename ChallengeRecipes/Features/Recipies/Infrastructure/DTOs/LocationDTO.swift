//
//  LocationDTO.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//


struct LocationDTO: Decodable {
    let latitude: Double
    let longitude: Double
    
    func toModel() -> Location {
        return Location(latitude: latitude, longitude: longitude)
    }
}
