//
//  File.swift
//  
//
//  Created by Connor Jones on 07/07/2023.
//

import Foundation

public protocol IMDBRatingsServiceProtocol {
    func getRating(for titleId: String) async throws -> TitleRatingResponse
}

public class IMDBRatingService: IMDBRatingsServiceProtocol {
    let repository: IMDBRatingsRepositoryProtocol

    public init(repository: IMDBRatingsRepositoryProtocol) {
        self.repository = repository
    }

    public func getRating(for titleId: String) async throws -> TitleRatingResponse {
        try await repository.getRating(for: titleId)
    }
}
