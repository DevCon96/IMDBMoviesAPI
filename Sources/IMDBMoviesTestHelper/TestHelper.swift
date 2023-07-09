//
//  File.swift
//  
//
//  Created by Connor Jones on 07/07/2023.
//

import Foundation
import IMDBMoviesAPI

public class TestHelper {
    public static func rating(id: String? = nil, title: String = "", titleType: TitleType = .movie, year: Int = 0, rating: Float = 10.0, ratingCount: Int = 10) -> TitleRatingResponse {
        let rating = TitleRatingResponse(id: id ?? UUID().uuidString,
                                         title: title,
                                         titleType: titleType,
                                         year: year,
                                         otherRanks: [],
                                         rating: rating,
                                         ratingCount: ratingCount,
                                         ratingsHistograms: [])

        return rating
    }
}
