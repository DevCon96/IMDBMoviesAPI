//
//  IMDBApiProtocolImp.swift
//  MuviSelcta
//
//  Created by Connor Jones on 11/03/2023.
//

import Foundation

class IMDBTitlesServiceImpl: IMDBTitlesService {
    private var imdbServiceRepository: IMDBTitlesRespository

    init(imdbServiceRepository: IMDBTitlesRespository) {
        self.imdbServiceRepository = imdbServiceRepository
    }


    func getPopularMovies(for genre: Genre, count: Int) async throws -> [String] {
        try await imdbServiceRepository.getPopularMovies(for: genre, count: count)
    }

    func getTitleDetails(for id: String) async throws -> TitleDetailsResponse? {
        try await imdbServiceRepository.getTitleDetails(for: id)
    }

    func getPopularTvShows(count: Int) async throws -> [String] {
        try await imdbServiceRepository.getPopularTvShowsTitles(count: count)
    }

    func getPopularTvShows(count: Int) async throws -> [TitleDetailsResponse] {
        try await imdbServiceRepository.getPopularTvShows(count: count)
    }

    func getPopularFilms(with parmaters: [String : String]) async throws -> [TitleDetailsResponse] {
        try await imdbServiceRepository.getPopularFilms(with: parmaters)
    }

}
