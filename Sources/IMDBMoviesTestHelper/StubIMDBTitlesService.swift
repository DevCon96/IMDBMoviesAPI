//
//  File.swift
//  
//
//  Created by Connor Jones on 30/06/2023.
//

import Foundation
@testable import IMDBMoviesAPI

class StubIMDBTitlesService: IMDBTitlesServiceProtocol {
    var invokedFindTitleDetails = false
    var invokedFindTitleDetailsCount = 0
    var invokedFindTitleDetailsParameters: (searchTerm: String, Void)?
    var invokedFindTitleDetailsParametersList = [(searchTerm: String, Void)]()
    var stubbedFindTitlesDetails: SearchResultResponse!
    var stubbedFindTitleDetailsErrorReturn: Error!
    var findTitleDetailsShouldError: Bool = false
    
    func find(_ searchTerm: String) async throws -> SearchResultResponse? {
        guard !findTitleDetailsShouldError else { throw stubbedFindTitleDetailsErrorReturn }
        invokedFindTitleDetails = true
        invokedFindTitleDetailsCount += 1
        invokedFindTitleDetailsParameters = (searchTerm, ())
        invokedGetTitleDetailsParametersList.append((searchTerm, ()))
        return stubbedFindTitlesDetails
        
    }
    

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
    var stubbedGetPopularShows: [String]!
    var stubbedGetPopularTvShowsErrorReturn: Error!
    var getPopularTvShowsShouldError: Bool = false

    func getPopularTvShows() async throws -> [String]  {
        guard !getPopularTvShowsShouldError else { throw stubbedGetPopularTvShowsErrorReturn }
        invokedGetPopularTvShows = true
        invokedGetPopularTvShowsCount += 1
        return stubbedGetPopularShows
    }
}
