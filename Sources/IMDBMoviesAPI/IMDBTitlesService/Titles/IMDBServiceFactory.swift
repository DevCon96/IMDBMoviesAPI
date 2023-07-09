//
//  IMDBTitlesServiceFactory.swift
//  MuviSelcta
//
//  Created by Connor Jones on 02/06/2023.
//

import Foundation

public class IMDBServiceFactory {
    public static func titlesService() -> IMDBTitlesServiceProtocol {
        return IMDBTitlesService(imdbServiceRepository: IMDBTitlesRepository())
    }

    public static func ratingsService() -> IMDBRatingsServiceProtocol {
        return IMDBRatingService(repository: IMDBRatingsRepository())
    }
}
