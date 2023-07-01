//
//  File.swift
//  
//
//  Created by Connor Jones on 30/06/2023.
//

import Foundation
@testable import IMDBMoviesAPI

class StubIMDBTitlesService: IMDBTitlesServiceProtocol {

    var invokedGetTitleDetails = false
    var invokedGetTitleDetailsCount = 0
    var invokedGetTitleDetailsParameters: (id: String, Void)?
    var invokedGetTitleDetailsParametersList = [(id: String, Void)]()
    var stubbedGetTitlesDetails: TitleDetailsResponse!
    var stubbedGetTitleDetailsErrorReturn: Error!
    var getTitleDetailsShouldError: Bool = false

    func getTitleDetails(for id: String) async throws -> TitleDetailsResponse? {
        guard !getTitleDetailsShouldError else { throw stubbedGetTitleDetailsErrorReturn }
        invokedGetTitleDetails = true
        invokedGetTitleDetailsCount += 1
        invokedGetTitleDetailsParameters = (id, ())
        invokedGetTitleDetailsParametersList.append((id, ()))
        return stubbedGetTitlesDetails
    }

    var invokedGetPopularMovies = false
    var invokedGetPopularMoviesCount = 0
    var invokedGetPopularMoviesParameters: (genre: Genre, count: Int)?
    var invokedGetPopularMoviesParametersList = [(genre: Genre, count: Int)]()
    var stubbedGetPopularMovies: [String]!
    var stubbedGetPopularMoviesErrorReturn: Error!
    var getPopularMoviesShouldError: Bool = false

    func getPopularMovies(for genre: Genre, count: Int) async throws -> [String] {
        guard !getPopularMoviesShouldError else { throw stubbedGetPopularMoviesErrorReturn }
        invokedGetPopularMovies = true
        invokedGetPopularMoviesCount += 1
        invokedGetPopularMoviesParameters = (genre, count)
        invokedGetPopularMoviesParametersList.append((genre, count))
        return stubbedGetPopularMovies
    }

    var invokedGetPopularTvShows = false
    var invokedGetPopularTvShowsCount = 0
    var invokedGetPopularTvShowsParameters: (count: Int, Void)?
    var invokedGetPopularTvShowsParametersList = [(count: Int, Void)]()
    var stubbedGetPopularShows: [String]!
    var stubbedGetPopularTvShowsErrorReturn: Error!
    var getPopularTvShowsShouldError: Bool = false

    func getPopularTvShows(count: Int) async throws -> [String]  {
        guard !getPopularTvShowsShouldError else { throw stubbedGetPopularTvShowsErrorReturn }
        invokedGetPopularTvShows = true
        invokedGetPopularTvShowsCount += 1
        invokedGetPopularTvShowsParameters = (count, ())
        invokedGetPopularTvShowsParametersList.append((count, ()))
        return stubbedGetPopularShows
    }
}
