import Foundation

public struct Config: Decodable {
    public static let shared: Config = Config()
    public var imdbApiKey: String?
    public var imdbUrl: String?

    public init() {
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
