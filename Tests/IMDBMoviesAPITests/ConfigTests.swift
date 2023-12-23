//
//  ConfigTests.swift
//  
//
//  Created by Connor Jones on 19/06/2023.
//

import XCTest
@testable import IMDBMoviesAPI

final class ConfigTests: XCTestCase {

    func testFetchingBaseUrl() throws {
        let expectedUrl = "https://imdb8.p.rapidapi.com"
        let expectedApiKey = "f00295303dmsh8abbb960a723b5cp15819fjsnfe700d92d7ad"

        XCTAssertEqual(expectedUrl, Config.shared.rootUrl)
        XCTAssertEqual(expectedApiKey, Config.shared.apiKey)
    }
}
