import Foundation

public struct TitleDetailsResponse: Codable, Identifiable {
    public var id: String
    public var type: String?
    public var image: TitlePosterInformation?
    public var movieLength: Int?
    public var nextEpisode: String?
    public var numberOfEpisodes: Int?
    public var seriesEndYear: Int?
    public var seriesStartYear: Int?
    public var title: String
    public var titleType: TitleType?
    public var year: Int?
    public var genre: Genre?

    public enum CodingKeys: String, CodingKey {
        case type = "@type"
        case movieLength = "runningTimeInMinutes"
        case id, image, nextEpisode, numberOfEpisodes, seriesEndYear, seriesStartYear, title, titleType, year
    }

    public init(type: String,image: TitlePosterInformation, id: String, movieLength: Int, nextEpisode: String, numberOfEpisodes: Int, seriesEndYear: Int, seriesStartYear: Int, title: String, titleType: String, year: Int) {
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
    public var id: String
    public var url: String
    public var height: Int
    public var width: Int

    public init(id: String, url: String, height: Int, width: Int) {
        self.id = id
        self.url = url
        self.height = height
        self.width = width
    }
}

public enum TitleType: String, Codable, CaseIterable {
    case movie, tvSeries, tvMovie, tvSpecial, video, videoGame, podcastSeries, unknown

    public func toString() -> String? {
        switch self {
        case .movie: return Strings.DownloadNew.filmsSelectorLabel
        case .tvSeries: return Strings.DownloadNew.tvSeriesSelectorLabel
        case .video: return Strings.DownloadNew.videosSelectorLabel
        case .tvMovie: return Strings.DownloadNew.tvMovieSelectorLabel
        case .videoGame: return Strings.DownloadNew.videoGameSelectorLabel
        case .podcastSeries: return Strings.DownloadNew.podcastSeriesSelectorLabel
        case .tvSpecial: return Strings.DownloadNew.podcastSeriesSelectorLabel
        default: return nil
        }
    }
}
