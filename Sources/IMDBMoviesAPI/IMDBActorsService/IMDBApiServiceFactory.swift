//
//  IMDBApiServiceFactory.swift
//  MuviSelcta
//
//  Created by Connor Jones on 11/03/2023.
//

import Foundation

class IMDServiceFactory {
    /// Create a new `IMDBService` object
    /// - Returns: the configured `IMDBService` ready for use

    public static func apiService() -> IMDBTitlesService {
        IMDBTitlesServiceImpl(imdbServiceRepository: IMDBTitlesResultsRepository())
    }
}
