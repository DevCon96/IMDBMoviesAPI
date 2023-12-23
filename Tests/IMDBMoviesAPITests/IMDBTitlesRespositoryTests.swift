//
//  IMDBTitlesRespositoryTests.swift
//
//
//  Created by Connor Jones on 08/12/2023.
//

import Foundation
import XCTest
import IMDBMoviesTestHelper
@testable import IMDBMoviesAPI

final class IMDBTitlesRespositoryTests: XCTestCase {
    var titlesRepository: IMDBTitlesRepository!
    
    override func setUp() {
        titlesRepository = IMDBTitlesRepository()
    }

    func testGetPopularMoviesForGenre() async throws {
        // Given
        let genre = Genre.crime
        let amount = 6
        
        // When
        let result = try await titlesRepository.getPopularMovies(for: genre, count: amount)
        
        // Then
        XCTAssertEqual(result.count, amount)
    }
    
    func testGetPopularTvShowsTitles() async throws {
        // Given
        let amount = 100
        
        // When
        let result = try await titlesRepository.getPopularTvShowsTitles()
        
        // Then
        XCTAssertEqual(result.count, amount)
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
    
    func testGetTitleDetails() async throws {
        // Given
        // Given
        let expectedTitleId = "/title/tt27542448/"
        let expectedImageUrl = "https://m.media-amazon.com/images/M/MV5BZTdkMDA5YjktODQzNC00N2VhLTg5NmItOTAwNjg3OTIyYTk3XkEyXkFqcGdeQXVyMTUzOTczNzYx._V1_.jpg"

        let decoder = JSONDecoder()
        let testData = try XCTUnwrap(TestData.details.data(using: .utf8))
        let testDetails = try? decoder.decode(TitleDetailsResponse.self, from: testData)
        let unwrappedDetails = try XCTUnwrap(testDetails)
        let sanatisedTitleId = unwrappedDetails.id
            .replacingOccurrences(of: "/title/", with: "")
            .replacingOccurrences(of: "/", with: "")
        // When
        let result = try await titlesRepository.getTitleDetails(for: sanatisedTitleId)
        
        // Then
        XCTAssertEqual(unwrappedDetails.id, result?.id)
    }
}
