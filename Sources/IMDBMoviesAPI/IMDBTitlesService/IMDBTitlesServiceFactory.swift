//
//  IMDBTitlesServiceFactory.swift
//  MuviSelcta
//
//  Created by Connor Jones on 02/06/2023.
//

import Foundation

public class IMDBTitlesServiceFactory {
    public static func titlesService() -> IMDBTitlesService {
        return IMDBTitlesServiceImpl(imdbServiceRepository: IMDBTitlesResultsRepository())
    }
}
