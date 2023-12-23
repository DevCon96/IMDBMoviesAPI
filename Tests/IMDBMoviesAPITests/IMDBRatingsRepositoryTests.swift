//
//  File.swift
//  
//
//  Created by Connor Jones on 07/07/2023.
//

import Foundation
import XCTest
@testable import IMDBMoviesAPI

/// WARNING: This calls remote APIs so a change to remote data will break tests.
final class IMDBRatingsRepositoryTests: XCTestCase {

    let repository = IMDBRatingsRepository()

    override func setUp() async throws {

    }

    func testGetRatings() async throws {
        // Given
        let testTitleId = "tt27542448"
        let expectedTitleName = "Take Care of Maya"
        let expectedTitleType: TitleType = .movie
        let expectedYear: Int = 2023
        // Rating can change
//        let expectdRating: Float = 7.9

        var result: TitleRatingResponse?

        // When
        do {
            result = try await repository.getRating(for: testTitleId)
        } catch let error {
            print(error)
            XCTFail()
        }

        // Then
        if let result {
            XCTAssertEqual(expectedTitleName, result.title)
            XCTAssertEqual(testTitleId, result.id)
            XCTAssertEqual(expectedTitleType, result.titleType)
            XCTAssertEqual(expectedYear, result.year)
            // Rating can change
//            XCTAssertEqual(expectdRating, result.rating)
        } else {
            XCTFail()
        }

        // TitleRatingResponse(id: "tt27542448", title: "Take Care of Maya", titleType: IMDBMoviesAPI.TitleType.movie, year: 2023, rating: 7.9, ratingCount: 3793)
    }
}
