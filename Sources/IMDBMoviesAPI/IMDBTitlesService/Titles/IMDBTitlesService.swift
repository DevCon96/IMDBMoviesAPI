//
//  IMDBApiProtocolImp.swift
//  MuviSelcta
//
//  Created by Connor Jones on 11/03/2023.
//

import Foundation

public class IMDBTitlesService: IMDBTitlesServiceProtocol {
    private var imdbServiceRepository: IMDBTitlesRespositoryProtocol

    public init(imdbServiceRepository: IMDBTitlesRespositoryProtocol) {
        self.imdbServiceRepository = imdbServiceRepository
    }


    public func getPopularMovies(for genre: Genre, count: Int) async throws -> [String] {
        try await imdbServiceRepository.getPopularMovies(for: genre, count: count)
    }

    public func getTitleDetails(for id: String) async throws -> TitleDetailsResponse? {
        try await imdbServiceRepository.getTitleDetails(for: id)
    }

    public func getPopularTvShows(count: Int) async throws -> [String] {
        try await imdbServiceRepository.getPopularTvShowsTitles(count: count)
    }

    public func getPopularTvShows(count: Int) async throws -> [TitleDetailsResponse] {
        try await imdbServiceRepository.getPopularTvShows(count: count)
    }

    public func getPopularFilms(with parmaters: [String : String]) async throws -> [TitleDetailsResponse] {
        try await imdbServiceRepository.getPopularFilms(with: parmaters)
    }

}
