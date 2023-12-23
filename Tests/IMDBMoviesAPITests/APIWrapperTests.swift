//
//  APIWraperTests.swift
//  !!! Warning - These tests call apis and are therefore integration tests
//  These tests are to enfore documentation of the json data structure so
//  a local version of the format is stored and maintained
//
//  Created by Connor Jones on 26/06/2023.
//

import Foundation
import XCTest
@testable import IMDBMoviesAPI

final class APIWrapperTests: XCTestCase {

    func testDecodingPopularTitlesResponse() throws {
        // Given
        let expectedFirstTItleId = "/title/tt6856242/"
        let decoder = JSONDecoder()
        let testData = try XCTUnwrap(TestData.popular.data(using: .utf8))


        // When
        let result = try? decoder.decode([String].self, from: testData)
        let resultUnwrapped = try XCTUnwrap(result)

        // Then
        XCTAssertEqual(100, resultUnwrapped.count)
        XCTAssertEqual(expectedFirstTItleId, resultUnwrapped.first)
    }

    func testDecodingDetailsResponse() throws {
        // Given
        let expectedTitleId = "/title/tt0944947/"
        let expectedImageUrl = "https://m.media-amazon.com/images/M/MV5BYTRiNDQwYzAtMzVlZS00NTI5LWJjYjUtMzkwNTUzMWMxZTllXkEyXkFqcGdeQXVyNDIzMzcwNjc@._V1_.jpg"

        let decoder = JSONDecoder()
        let testData = try XCTUnwrap(TestData.details.data(using: .utf8))

        // When
        let result = try? decoder.decode(TitleDetailsResponse.self, from: testData)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(expectedTitleId, result?.id)
        XCTAssertEqual(expectedImageUrl, result?.image?.url)
    }

    func testDecodingDetails2Response() throws {
        // Given
        let expectedTitleId = "/title/tt27542448/"
        let expectedImageUrl = "https://m.media-amazon.com/images/M/MV5BZTdkMDA5YjktODQzNC00N2VhLTg5NmItOTAwNjg3OTIyYTk3XkEyXkFqcGdeQXVyMTUzOTczNzYx._V1_.jpg"

        let decoder = JSONDecoder()
        let testData = try XCTUnwrap(TestData.details2.data(using: .utf8))

        // When
        let result = try? decoder.decode(TitleDetailsResponse.self, from: testData)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(expectedTitleId, result?.id)
        XCTAssertEqual(expectedImageUrl, result?.image?.url)
    }
}
