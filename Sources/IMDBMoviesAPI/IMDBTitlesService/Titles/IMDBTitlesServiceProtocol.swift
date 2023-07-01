//
//  IMDBService.swift
//  MuviSelcta
//
//  Created by Connor Jones on 11/03/2023.
//

import Foundation

public protocol IMDBTitlesServiceProtocol {

    /// Fetch details for specific title id
    /// - Parameter id: The specific identifier for a particular title.
    func getTitleDetails(for id: String) async throws -> TitleDetailsResponse?

    /// - Description:
    ///     - Download the most popular movies for a particular genre.
    /// - Parameters:
    ///     - genre: The genre of movies to download
    ///     - count: The number of movies starting with the most popular to (count -1)th most popular movie
    func getPopularMovies(for genre: Genre, count: Int) async throws -> [String]

    /// - Description:
    ///     - Download the most popular TV shows for a particular genre.
    /// - Parameters:
    ///     - genre: The genre of movies to download
    ///     - count: The number of movies starting with the most popular to (count -1)th most popular movie
    func getPopularTvShows(count: Int) async throws -> [String]

    // - Description:
    ///     - Download the most popular films with given parameters
    /// - Parameters:
    ///     - parameters: Dict of key values for paramters
    ///
}
