//
//  File.swift
//  
//
//  Created by Connor Jones on 07/07/2023.
//

import Foundation

fileprivate let timeoutInterval = 10.0

public protocol IMDBRatingsRepositoryProtocol {
    func getRating(for titleId: String) async throws -> TitleRatingResponse
}

class IMDBRatingsRepository: IMDBRatingsRepositoryProtocol {
    public func getRating(for titleId: String) async throws -> TitleRatingResponse {
        var rating: TitleRatingResponse?

        let apiMethod = "get-ratings"
        let request = NSMutableURLRequest(url: URL(string: "\(IMDBTitlesRepository.hostUrl)/title/\(apiMethod)?tconst=\(titleId)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesRepository.headers

        // TODO: Getting all null data back. Debug request
        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            rating = try? JSONDecoder().decode(TitleRatingResponse.self, from: data)
            // Sanatise better?
            if let id = rating?.id {
                rating?.id = id
                    .replacingOccurrences(of: "/title/", with: "")
                    .replacingOccurrences(of: "/", with: "")
            }
        } catch {
            throw MovieSearcherError.noDataFetched
        }

        guard let rating else { throw MovieSearcherError.noDataFetched }
        
        return rating
    }
}
