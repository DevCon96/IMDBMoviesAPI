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
    
    public static func title() -> TitleDetailsResponse {
        let image = TitlePosterInformation(id: "image",
                                           url: "url",
                                           height: 150,
                                           width: 150)
        return TitleDetailsResponse(type: "film",
                                    image: image,
                                    id: "tt00000001",
                                    movieLength: 120,
                                    nextEpisode: "tt00000002", 
                                    numberOfEpisodes: 12,
                                    seriesEndYear: 2023,
                                    seriesStartYear: 2020,
                                    title: "Moovie",
                                    titleType: "film",
                                    year: 2023)
    }
}
