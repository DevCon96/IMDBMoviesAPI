import Foundation

public struct Config: Decodable {
    public static let shared: Config = Config()
    public var apiKey: String?
    public var rootUrl: String?
    
    public var imdbConfig: IMDBConfig?

    public init() {
        print("Initalised Config")
        if let url = Bundle.module.url(forResource: "Config", withExtension: "json"){
            do {
                let data = try Data(contentsOf: url)
                 self = try! JSONDecoder().decode(Config.self, from: data)
            } catch {
                print("ERROR : \(#file) : Unable to decode config")
            }
        }
    }
}

public struct IMDBConfig: Decodable {
    public let findPath: String
    public let titlesPath: String
    public let actorsPath: String
    public let mostPopularPath: String
}
