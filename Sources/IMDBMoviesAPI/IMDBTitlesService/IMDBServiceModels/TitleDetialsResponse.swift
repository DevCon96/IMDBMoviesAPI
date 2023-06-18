//
//  IMDBModel.swift
//  MuviSelcta
//
//  Created by Connor Jones on 11/03/2023.
//
import Foundation

public struct TitleDetailsResponse: Codable, Identifiable {
    public var id: String
    var type: String
    var image: TitlePosterInformation
    var movieLength: Int
    var nextEpisode: String?
    var numberOfEpisodes: Int?
    var seriesEndYear: Int?
    var seriesStartYear: Int?
    var title: String
    var titleType: TitleType
    var year: Int
    var genre: Genre?

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case movieLength = "runningTimeInMinutes"
        case id, image, nextEpisode, numberOfEpisodes, seriesEndYear, seriesStartYear, title, titleType, year
    }

    init(type: String,image: TitlePosterInformation, id: String, movieLength: Int, nextEpisode: String, numberOfEpisodes: Int, seriesEndYear: Int, seriesStartYear: Int, title: String, titleType: String, year: Int) {
        self.type = type
        self.titleType = TitleType(rawValue: titleType) ?? .unknown
        self.title = title
        self.nextEpisode = nextEpisode
        self.year = year
        self.id = id
        self.seriesStartYear = seriesStartYear
        self.seriesEndYear = seriesEndYear
        self.movieLength = movieLength
        self.numberOfEpisodes = numberOfEpisodes
        self.image = image//TitlePosterInformation(id: "N/A", url: "N/A", height: 50, width: 50)
    }
}

public struct TitlePosterInformation: Codable {
    var id: String
    var url: String
    var height: Int
    var width: Int
}

public enum TitleType: String, Codable, CaseIterable {
    case film, tvSeries, unknown

    public func toString() -> String? {
        switch self {
        case .film: return Strings.DownloadNew.filmsSelectorLabel
        case .tvSeries: return Strings.DownloadNew.tvSeriesSelectorLabel
        default: return nil
        }
    }
}
