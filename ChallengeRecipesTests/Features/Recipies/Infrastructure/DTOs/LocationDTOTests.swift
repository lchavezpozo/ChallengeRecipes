//
//  LocationDTOTests.swift
//  ChallengeRecipesTests
//
//  Created by Luis Chavez pozo on 12/02/25.
//

import XCTest
@testable import ChallengeRecipes

final class LocationDTOTests: XCTestCase {
    func test_locationDTO_decoding() throws {
        // Given
        let json = """
        {
            "latitude": 37.7749,
            "longitude": -122.4194
        }
        """.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        let locationDTO = try decoder.decode(LocationDTO.self, from: json)

        // Then
        XCTAssertEqual(locationDTO.latitude, 37.7749)
        XCTAssertEqual(locationDTO.longitude, -122.4194)
    }
    
    func test_locationDTO_toModel() throws {
        // Given
        let locationDTO = LocationDTO(latitude: 37.7749, longitude: -122.4194)
        
        // When
        let locationModel = locationDTO.toModel()
        
        // Then
        XCTAssertEqual(locationModel.latitude, 37.7749)
        XCTAssertEqual(locationModel.longitude, -122.4194)
    }
}
