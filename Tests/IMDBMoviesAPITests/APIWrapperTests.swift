//
//  File.swift
//  !!! Warning - These tests call apis and are therefore integration tests
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
        XCTAssertEqual(expectedImageUrl, result?.image.url)
    }
}
