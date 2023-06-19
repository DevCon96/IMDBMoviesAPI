
import Foundation

fileprivate let timeoutInterval = 10.0

public protocol IMDBTitlesRespository {
    // Movies/Films
    func getPopularMovies(for genre: Genre, count: Int) async throws -> [String]
    func getPopularFilms(with parmaters: [String : String]) async throws -> [TitleDetailsResponse]

    // TV Shows
    func getPopularTvShowsTitles(count: Int) async throws -> [String]
    func getPopularTvShows(count: Int) async throws -> [TitleDetailsResponse]

    // Common
    func getTitleDetails(for id: String) async throws -> TitleDetailsResponse?
    func getRating(for title: String) async throws -> TitleRatingResponse?
    func findTitle(for searchString: String) async throws -> [TitleDetailsResponse]
}

public class IMDBTitlesResultsRepository: IMDBTitlesRespository {
    private static var apiKey: String = Config.main.imdbApiKey ?? "" //"f00295303dmsh8abbb960a723b5cp15819fjsnfe700d92d7ad"
    private static let hostUrl = Config.main.imdbUrl ?? ""//"imdb8.p.rapidapi.com"
    private static let networkProtocol = "https:"

    private static let headers = [
        "X-RapidAPI-Key": apiKey,
        "X-RapidAPI-Host": hostUrl
    ]

    public func getPopularMovies(for genre: Genre, count: Int) async throws -> [String] {
        let apiMethod = "get-popular-movies-by-genre"

        guard let url = URL(string: "\(IMDBTitlesResultsRepository.hostUrl)/title/v2/\(apiMethod)?genre=\(genre.rawValue)&limit=\(String(count))") else { throw MovieSearcherError.noDataFetched }

        var responseData: [String] = []
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            let titleComponents = String(data: data, encoding: .utf8)!
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: "\"/title/", with: "")
                .replacingOccurrences(of: "/\"", with: "")
                .components(separatedBy: ",")
            titleComponents.forEach { responseData.append($0) }
        } catch {
            throw MovieSearcherError.noDataFetched
        }

        return responseData
    }

    public func getTitleDetails(for id: String) async throws -> TitleDetailsResponse? {
        let apiMethod = "get-details"

        guard let url = URL(string: "\(IMDBTitlesResultsRepository.hostUrl)/title/\(apiMethod)?tconst=\(id)") else {

            throw MovieSearcherError.noDataFetched
        }

        var result: TitleDetailsResponse?
        var urlRequest = URLRequest(url: url,
                                cachePolicy: .useProtocolCachePolicy,
                                timeoutInterval: timeoutInterval)

        urlRequest.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers
        urlRequest.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest as URLRequest)
            result = try? JSONDecoder().decode(TitleDetailsResponse.self, from: data)
        } catch {
            throw MovieSearcherError.noDataFetched
        }

        return result
    }

    public func getPopularTvShowsTitles(count: Int) async throws -> [String] {
        var responseData: [String] = []
        let apiMethod = "get-most-popular-tv-shows"

        guard let url = URL(string: "\(IMDBTitlesResultsRepository.hostUrl)/title/v2/\(apiMethod)?homeCountry=US&purchaseCountry=US&currentCountry=US") else {

            throw MovieSearcherError.noDataFetched
        }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            let titleComponents = sanatizeTitleData(data)
            titleComponents.forEach { responseData.append($0) }
        } catch {
            throw MovieSearcherError.noDataFetched
        }

        return responseData

    }

    public func getPopularTvShows(count: Int) async throws -> [TitleDetailsResponse] {
        var result: [TitleDetailsResponse] = []

        let popularShows = try await self.getPopularTvShowsTitles(count: count)

        for show in popularShows {
            let titleDetails = try await self.getTitleDetails(for: show)
            if let titleDetails {
                result.append(titleDetails)
            }
        }

        return result
    }

    public func getRating(for title: String) async throws -> TitleRatingResponse? {


        let apiMethod = "get-ratings"

        guard let url = URL(string: "\(IMDBTitlesResultsRepository.hostUrl)/\(apiMethod)?tconst=\(title)") else {

            throw MovieSearcherError.noDataFetched
        }

        var rating: TitleRatingResponse?
        var request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            rating = try? JSONDecoder().decode(TitleRatingResponse.self, from: data)
        } catch {
            throw MovieSearcherError.noDataFetched
        }

        return rating
    }

    public func getPopularFilms(with parmaters: [String : String]) async throws -> [TitleDetailsResponse] {
        return []
    }

    public func findTitle(for searchString: String) async throws -> [TitleDetailsResponse] {

        let apiMethod = "find"
        guard let url = URL(string: "\(IMDBTitlesResultsRepository.hostUrl)/\(apiMethod)?q=\(searchString)") else {

            throw MovieSearcherError.noDataFetched
        }

        var result: [TitleDetailsResponse]?
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            result = try? JSONDecoder().decode([TitleDetailsResponse].self, from: data)
        } catch {
            throw MovieSearcherError.noDataFetched
        }

        return result ?? []
    }

    private func sanatizeTitleData(_ titleData: Data) -> [String] {
        String(data: titleData, encoding: .utf8)!
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: "\"/title/", with: "")
            .replacingOccurrences(of: "/\"", with: "")
            .components(separatedBy: ",")
    }
}
