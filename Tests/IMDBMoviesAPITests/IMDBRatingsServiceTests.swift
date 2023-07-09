//
//  IMDBRatingsServiceTests.swift
//  
//
//  Created by Connor Jones on 07/07/2023.
//

import XCTest
import IMDBMoviesTestHelper
@testable import IMDBMoviesAPI

final class IMDBRatingsServiceTests: XCTestCase {
    let stubbedRatingsRepository = StubRatingsRepository()

    override func setUpWithError() throws {

    }

    func testGetRatings() async throws {
        // Given
        let expectedResult = TestHelper.rating()
        stubbedRatingsRepository.stubbedGetRatingReturn = expectedResult

        // When
//        let result = try await stubbedRatingsRepository.getRating(for: expectedResult.title)

        // Then
//        XCTAssertTrue(stubbedRatingsRepository.invokedGetRating)
//        XCTAssertEqual(expectedResult.title, result.title)
//        XCTAssertEqual(expectedResult.rating, result.rating)
    }

    func testGetRatingsErrors() async throws {
        // Given
        let expectedError = MovieSearcherError.noDataFetched
        stubbedRatingsRepository.shouldGetRatingsError = true
    }

}
