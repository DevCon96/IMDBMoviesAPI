//
//  StubRatingsRepository.swift
//  
//
//  Created by Connor Jones on 30/06/2023.
//

import Foundation
import IMDBMoviesAPI

public class StubRatingsRepository: IMDBRatingsRepositoryProtocol {

    public var invokedGetRating = false
    public var invokedGetRatingCount = 0
    public var invokedGetRatingParameters: (titleId: String, Void)?
    public var invokedGetRatingParametersList = [(titleId: String, Void)]()
    public var stubbedGetRatingReturn: TitleRatingResponse!
    public var stubbedGetRatingError: Error!
    public var shouldGetRatingsError = false

    public init(invokedGetRating: Bool = false, invokedGetRatingCount: Int = 0, invokedGetRatingParameters: (titleId: String, Void)? = nil, invokedGetRatingParametersList: [(titleId: String, Void)] = [(titleId: String, Void)](), shouldGetRatingsError: Bool = false) {
        self.invokedGetRating = invokedGetRating
        self.invokedGetRatingCount = invokedGetRatingCount
        self.invokedGetRatingParameters = invokedGetRatingParameters
        self.invokedGetRatingParametersList = invokedGetRatingParametersList
        self.shouldGetRatingsError = shouldGetRatingsError
    }
    public func getRating(for titleId: String) async throws -> TitleRatingResponse {
        guard !shouldGetRatingsError else { throw stubbedGetRatingError }
        invokedGetRating = true
        invokedGetRatingCount += 1
        invokedGetRatingParameters = (titleId, ())
        invokedGetRatingParametersList.append((titleId, ()))

        return stubbedGetRatingReturn
    }
}
