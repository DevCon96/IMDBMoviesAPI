import Foundation

public struct Config: Decodable {
    public static var main = Config()

    public var imdbApiKey: String?
    public var imdbUrl: String?

    public init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "json"),
           let url = URL(string: path) {
            do {
                let data = try Data(contentsOf: url)
                self = try! JSONDecoder().decode(Config.self, from: data)
            } catch { }
        }
    }
}
