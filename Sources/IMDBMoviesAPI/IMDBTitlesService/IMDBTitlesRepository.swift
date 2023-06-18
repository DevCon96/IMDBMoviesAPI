//
//  IMDBServiceRepository.swift
//  MuviSelcta
//
//  Created by Connor Jones on 11/03/2023.
//

import Foundation

fileprivate let timeoutInterval = 10.0

protocol IMDBTitlesRespository {
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

class IMDBTitlesResultsRepository: IMDBTitlesRespository {
    private static var apiKey: String = Config.main.imdbApiKey ?? "" //"f00295303dmsh8abbb960a723b5cp15819fjsnfe700d92d7ad"
    private static let hostUrl = Config.main.imdbUrl ?? ""//"imdb8.p.rapidapi.com"
    private static let networkProtocol = "https:"

    private static let headers = [
        "X-RapidAPI-Key": apiKey,
        "X-RapidAPI-Host": hostUrl
    ]

    public func getPopularMovies(for genre: Genre, count: Int) async throws -> [String] {
        var responseData: [String] = []
        let apiMethod = "get-popular-movies-by-genre"
        let request = NSMutableURLRequest(url: NSURL(string: "\(IMDBTitlesResultsRepository.hostUrl)/title/v2/\(apiMethod)?genre=\(genre.rawValue)&limit=\(String(count))")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)

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
            log(.error, "Unable to fetch popular movies for \(genre.rawValue)")
//            AnalyticsManager.logEvent(.errorFetchingPopularMovies, [
//                "gnere" : genre.rawValue,
//                "count" : count
//            ])
            throw MovieSearcherError.noDataFetched
        }

        return responseData
    }

    public func getTitleDetails(for id: String) async throws -> TitleDetailsResponse? {
        var result: TitleDetailsResponse?
        let apiMethod = "get-details"

        var urlRequest: URLRequest?

        guard let url = URL(string: "\(IMDBTitlesResultsRepository.hostUrl)/title/\(apiMethod)?tconst=\(id)") else {
            return nil
        }

        urlRequest = URLRequest(url: url,
                                cachePolicy: .useProtocolCachePolicy,
                                timeoutInterval: timeoutInterval)
        print("\(IMDBTitlesResultsRepository.hostUrl)/title/\(apiMethod)?tconst=\(id)")
        urlRequest?.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers
        urlRequest?.httpMethod = "GET"

        guard let urlRequest else { return  nil }

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest as URLRequest)
            result = try? JSONDecoder().decode(TitleDetailsResponse.self, from: data)
        } catch {
            log(.error, "Data not found from API call")
//            AnalyticsManager.logEvent(.errorFetchingTitleDetails, ["title" : id])
            throw MovieSearcherError.noDataFetched
        }

        return result
    }

    public func getPopularTvShowsTitles(count: Int) async throws -> [String] {
        var responseData: [String] = []
        let apiMethod = "get-most-popular-tv-shows"
        let request = NSMutableURLRequest(url: NSURL(string: "\(IMDBTitlesResultsRepository.hostUrl)/title/v2/\(apiMethod)?homeCountry=US&purchaseCountry=US&currentCountry=US")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            let titleComponents = sanatizeTitleData(data)
            titleComponents.forEach { responseData.append($0) }
        } catch {
            log(.error, "Undable to fetch popular TV shows list")
//            AnalyticsManager.logEvent(.errorFetchingPopularTvShows, ["count" : count])
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

    func getRating(for title: String) async throws -> TitleRatingResponse? {
        var rating: TitleRatingResponse?

        let apiMethod = "get-ratings"
        let request = NSMutableURLRequest(url: URL(string: "\(IMDBTitlesResultsRepository.hostUrl)/\(apiMethod)?tconst=\(title)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            rating = try? JSONDecoder().decode(TitleRatingResponse.self, from: data)
        } catch {
            log(.error, "Unable to fetch ratings data for titleID(\(title))")
            let params = [ "title" : title]
//            AnalyticsManager.logEvent(.errorFetchingRatingsData, params)
            throw MovieSearcherError.noDataFetched
        }

        return rating
    }

    public func getPopularFilms(with parmaters: [String : String]) async throws -> [TitleDetailsResponse] {
        return []
    }

    public func findTitle(for searchString: String) async throws -> [TitleDetailsResponse] {
        var result: [TitleDetailsResponse]?

        let apiMethod = "find"
        let request = NSMutableURLRequest(url: URL(string: "\(IMDBTitlesResultsRepository.hostUrl)/\(apiMethod)?q=\(searchString)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesResultsRepository.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            result = try? JSONDecoder().decode([TitleDetailsResponse].self, from: data)
        } catch {
            log(.error, "Unable to find any titles ")
//            AnalyticsManager.logEvent(.errorFindingTitles, ["searchString" : searchString])
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
