
import Foundation

fileprivate let timeoutInterval = 10.0

public protocol IMDBTitlesRespositoryProtocol {
    // Movies/Films
    func getPopularMovies(for genre: Genre, count: Int) async throws -> [String]
    func getPopularFilms(with parmaters: [String : String]) async throws -> [TitleDetailsResponse]

    // TV Shows
    func getPopularTvShowsTitles(count: Int) async throws -> [String]
    func getPopularTvShows(count: Int) async throws -> [TitleDetailsResponse]

    // Common
    func getTitleDetails(for id: String) async throws -> TitleDetailsResponse?
    func findTitle(for searchString: String) async throws -> SearchResultResponse?
}

public class IMDBTitlesRepository: IMDBTitlesRespositoryProtocol {


    static var apiKey: String = Config.shared.imdbApiKey ?? "" //"f00295303dmsh8abbb960a723b5cp15819fjsnfe700d92d7ad"
    static let hostUrl = Config.shared.imdbUrl ?? ""//"imdb8.p.rapidapi.com"
    static let networkProtocol = "https://"

    static let headers = [
        "X-RapidAPI-Key": apiKey,
        "X-RapidAPI-Host": hostUrl.replacingOccurrences(of: networkProtocol, with: "")
    ]

    public func getPopularMovies(for genre: Genre, count: Int) async throws -> [String] {
        var responseData: [String] = []
        let apiMethod = "get-popular-movies-by-genre"
        let request = NSMutableURLRequest(url: NSURL(string: "\(IMDBTitlesRepository.hostUrl)/title/v2/\(apiMethod)?genre=\(genre.rawValue)&limit=\(String(count))")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesRepository.headers

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
        var result: TitleDetailsResponse?
        let apiMethod = "get-details"

        var urlRequest: URLRequest?

        guard let url = URL(string: "\(IMDBTitlesRepository.hostUrl)/title/\(apiMethod)?tconst=\(id)") else {
            return nil
        }

        urlRequest = URLRequest(url: url,
                                cachePolicy: .useProtocolCachePolicy,
                                timeoutInterval: timeoutInterval)
        print("\(IMDBTitlesRepository.hostUrl)/title/\(apiMethod)?tconst=\(id)")
        urlRequest?.allHTTPHeaderFields = IMDBTitlesRepository.headers
        urlRequest?.httpMethod = "GET"

        guard let urlRequest else { return  nil }

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
        let request = NSMutableURLRequest(url: NSURL(string: "\(IMDBTitlesRepository.hostUrl)/title/v2/\(apiMethod)?homeCountry=US&purchaseCountry=US&currentCountry=US")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesRepository.headers

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



    public func getPopularFilms(with parmaters: [String : String]) async throws -> [TitleDetailsResponse] {
        return []
    }

    public func findTitle(for searchString: String) async throws -> SearchResultResponse? {
        var result: SearchResultResponse?
        let sanitizedSearchString = searchString.replacingOccurrences(of: " ", with: "%20")
        
        let apiMethod = "find"
        let request = NSMutableURLRequest(url: URL(string: "\(IMDBTitlesRepository.hostUrl)/title/\(apiMethod)?q=\(sanitizedSearchString)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = IMDBTitlesRepository.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            let jsonData = String(data: data, encoding: .utf8)
            result = try? JSONDecoder().decode(SearchResultResponse.self, from: data)
        } catch {
            throw MovieSearcherError.noDataFetched
        }

        return result
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
