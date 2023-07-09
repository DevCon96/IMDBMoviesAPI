import Foundation

public class IMDServiceFactory {
    /// Create a new `IMDBService` object
    /// - Returns: the configured `IMDBService` ready for use

    public static func apiService() -> IMDBTitlesServiceProtocol {
        IMDBTitlesService(imdbServiceRepository: IMDBTitlesRepository())
    }
}
