//
//  IMDBTitlesRespositoryTests.swift
//
//
//  Created by Connor Jones on 08/12/2023.
//

import Foundation
import XCTest
@testable import IMDBMoviesAPI

final class IMDBTitlesRespositoryTests: XCTestCase {
    var titlesRepository: IMDBTitlesRepository!
    
    override func setUp() {
        titlesRepository = IMDBTitlesRepository()
    }
    
    func testFindTitleForSearchTerm() async throws {
        // Given
        let searchQuery = "Game of Thrones"
        // When
        
        let response = try await titlesRepository.findTitle(for: searchQuery)
        
        if let response {
            // Then
            let result = try XCTUnwrap(response.results.first)
            XCTAssertEqual(result.title, searchQuery)
        } else {
            XCTFail()
        }
    }
}
