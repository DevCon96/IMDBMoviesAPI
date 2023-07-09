import Foundation

public struct TitleRatingResponse: Codable {
    public var id: String
    public var title: String
    public var titleType: TitleType
    public var year: Int
//    public var otherRanks: [OtherRanks]? // Not decoding
    public var rating: Float
    public var ratingCount: Int
//    public var ratingsHistograms: [GroupData]? // Not decoding

    public init(id: String, title: String, titleType: TitleType, year: Int, otherRanks: [OtherRanks]?, rating: Float, ratingCount: Int, ratingsHistograms: [GroupData]?) {
        self.id = id
        self.title = title
        self.titleType = titleType
        self.year = year
//        self.otherRanks = otherRanks
        self.rating = rating
        self.ratingCount = ratingCount
//        self.ratingsHistograms = ratingsHistograms
    }
}

public struct OtherRanks: Codable {
    public var id: String?
    public var label: String?
    public var rank: Int?
    public var rankType: String?

    public init(id: String, label: String, rank: Int, rankType: String) {
        self.id = id
        self.label = label
        self.rank = rank
        self.rankType = rankType
    }
}

public struct GroupData: Codable {
    public var aggregateRating: Float
    public var demographic: String
    public var histogram: [String : Int]
    public var totalRatings: Int

    public init(aggregateRating: Float, demographic: String, histogram: [String : Int] = [:], totalRatings: Int) {
        self.aggregateRating = aggregateRating
        self.demographic = demographic
        self.histogram = histogram
        self.totalRatings = totalRatings
    }
}

public struct HistogramData: Codable {
    public var oneStarTotal: Int?
    public var twoStarTotal: Int?
    public var threeStarTotal: Int?
    public var fourStarTotal: Int?
    public var fiveStarTotal: Int?
    public var sixStarTotal: Int?
    public var sevenStarTotal: Int?
    public var eightStarTotal: Int?
    public var nineStarTotal: Int?
    public var tenStarTotal: Int?

    public var data: [Int?] {
         [
            oneStarTotal,
            twoStarTotal,
            threeStarTotal,
            fourStarTotal,
            fiveStarTotal,
            fiveStarTotal,
            sixStarTotal,
            sevenStarTotal,
            eightStarTotal,
            nineStarTotal,
            tenStarTotal
         ]
    }

    public enum CodingKeys: String, CodingKey {
        case oneStarTotal = "1"
        case twoStarTotal = "2"
        case threeStarTotal = "3"
        case fourStarTotal = "4"
        case fiveStarTotal = "5"
        case sixStarTotal = "6"
        case sevenStarTotal = "7"
        case eightStarTotal = "8"
        case nineStarTotal = "9"
        case tenStarTotal = "10"
    }
}
/*
 {
   "@type": "imdb.api.title.ratings",
   "id": "/title/tt0944947/",
   "title": "Game of Thrones",
   "titleType": "tvSeries",
   "year": 2011,
   "canRate": true,
   "otherRanks": [
     {
       "id": "/chart/ratings/toptv",
       "label": "Top 250 TV",
       "rank": 13,
       "rankType": "topTv"
     }
   ],
   "rating": 9.2,
   "ratingCount": 1952444,
   "ratingsHistograms": {
     "Females Aged 45+": {
       "aggregateRating": 9.2,
       "demographic": "Females Aged 45+",
       "histogram": {
         "1": 710,
         "2": 161,
         "3": 168,
         "4": 163,
         "5": 303,
         "6": 446,
         "7": 948,
         "8": 2729,
         "9": 6865,
         "10": 18706
       },
       "totalRatings": 31199
     },
     "Aged under 18": {
       "aggregateRating": 9.1,
       "demographic": "Aged under 18",
       "histogram": {
         "1": 50,
         "2": 3,
         "3": 12,
         "4": 5,
         "5": 8,
         "6": 15,
         "7": 34,
         "8": 91,
         "9": 188,
         "10": 539
       },
       "totalRatings": 945
     },
     "Males": {
       "aggregateRating": 9.2,
       "demographic": "Males",
       "histogram": {
         "1": 29043,
         "2": 3001,
         "3": 3331,
         "4": 3978,
         "5": 8456,
         "6": 13643,
         "7": 34593,
         "8": 86872,
         "9": 205857,
         "10": 586701
       },
       "totalRatings": 975475
     },
     "Aged 30-44": {
       "aggregateRating": 9.2,
       "demographic": "Aged 30-44",
       "histogram": {
         "1": 15235,
         "2": 1953,
         "3": 2186,
         "4": 2640,
         "5": 5598,
         "6": 9117,
         "7": 23070,
         "8": 57690,
         "9": 137848,
         "10": 386160
       },
       "totalRatings": 641497
     },
     "Males Aged 45+": {
       "aggregateRating": 9.1,
       "demographic": "Males Aged 45+",
       "histogram": {
         "1": 2410,
         "2": 552,
         "3": 552,
         "4": 603,
         "5": 1142,
         "6": 1739,
         "7": 4022,
         "8": 10938,
         "9": 26383,
         "10": 54649
       },
       "totalRatings": 102990
     },
     "Top 1000 voters": {
       "aggregateRating": 8.5,
       "demographic": "Top 1000 voters",
       "histogram": {
         "1": 23,
         "2": 8,
         "3": 7,
         "4": 20,
         "5": 20,
         "6": 33,
         "7": 69,
         "8": 111,
         "9": 167,
         "10": 233
       },
       "totalRatings": 691
     },
     "Aged 18-29": {
       "aggregateRating": 9.3,
       "demographic": "Aged 18-29",
       "histogram": {
         "1": 13126,
         "2": 953,
         "3": 1098,
         "4": 1275,
         "5": 2665,
         "6": 4612,
         "7": 11932,
         "8": 29284,
         "9": 65394,
         "10": 216708
       },
       "totalRatings": 347047
     },
     "US users": {
       "aggregateRating": 9.2,
       "demographic": "US users",
       "histogram": {
         "1": 5152,
         "2": 644,
         "3": 751,
         "4": 829,
         "5": 1581,
         "6": 2512,
         "7": 6117,
         "8": 15346,
         "9": 35507,
         "10": 105365
       },
       "totalRatings": 173804
     },
     "Males Aged 18-29": {
       "aggregateRating": 9.3,
       "demographic": "Males Aged 18-29",
       "histogram": {
         "1": 10501,
         "2": 656,
         "3": 759,
         "4": 894,
         "5": 1950,
         "6": 3342,
         "7": 8796,
         "8": 21374,
         "9": 48052,
         "10": 159157
       },
       "totalRatings": 255481
     },
     "Females Aged 18-29": {
       "aggregateRating": 9.3,
       "demographic": "Females Aged 18-29",
       "histogram": {
         "1": 1794,
         "2": 208,
         "3": 264,
         "4": 307,
         "5": 559,
         "6": 964,
         "7": 2466,
         "8": 6086,
         "9": 13392,
         "10": 46491
       },
       "totalRatings": 72531
     },
     "Females Aged 30-44": {
       "aggregateRating": 9.3,
       "demographic": "Females Aged 30-44",
       "histogram": {
         "1": 2690,
         "2": 429,
         "3": 490,
         "4": 551,
         "5": 1091,
         "6": 1828,
         "7": 4692,
         "8": 11612,
         "9": 28100,
         "10": 82797
       },
       "totalRatings": 134280
     },
     "Males Aged under 18": {
       "aggregateRating": 9.2,
       "demographic": "Males Aged under 18",
       "histogram": {
         "1": 28,
         "2": 2,
         "3": 3,
         "4": 4,
         "5": 4,
         "6": 7,
         "7": 25,
         "8": 66,
         "9": 137,
         "10": 357
       },
       "totalRatings": 633
     },
     "Aged 45+": {
       "aggregateRating": 9.1,
       "demographic": "Aged 45+",
       "histogram": {
         "1": 3237,
         "2": 734,
         "3": 742,
         "4": 798,
         "5": 1498,
         "6": 2250,
         "7": 5136,
         "8": 14176,
         "9": 34468,
         "10": 75955
       },
       "totalRatings": 138994
     },
     "Females Aged under 18": {
       "aggregateRating": 7.1,
       "demographic": "Females Aged under 18",
       "histogram": {
         "1": 14,
         "2": 1,
         "3": 8,
         "4": 1,
         "5": 4,
         "6": 3,
         "7": 5,
         "8": 8,
         "9": 22,
         "10": 51
       },
       "totalRatings": 117
     },
     "IMDb Users": {
       "aggregateRating": 9.2,
       "demographic": "IMDb Users",
       "histogram": {
         "1": 62612,
         "2": 6685,
         "3": 7422,
         "4": 8703,
         "5": 17231,
         "6": 28057,
         "7": 70712,
         "8": 177319,
         "9": 413367,
         "10": 1160336
       },
       "totalRatings": 1952444
     },
     "Males Aged 30-44": {
       "aggregateRating": 9.2,
       "demographic": "Males Aged 30-44",
       "histogram": {
         "1": 12039,
         "2": 1440,
         "3": 1607,
         "4": 1993,
         "5": 4348,
         "6": 7025,
         "7": 17777,
         "8": 44392,
         "9": 105791,
         "10": 293263
       },
       "totalRatings": 489675
     },
     "IMDb Staff": {
       "aggregateRating": 8.7,
       "demographic": "IMDb Staff",
       "histogram": {
         "1": 0,
         "2": 0,
         "3": 0,
         "4": 0,
         "5": 1,
         "6": 3,
         "7": 5,
         "8": 21,
         "9": 27,
         "10": 18
       },
       "totalRatings": 75
     },
     "Non-US users": {
       "aggregateRating": 9.2,
       "demographic": "Non-US users",
       "histogram": {
         "1": 12950,
         "2": 1787,
         "3": 2045,
         "4": 2514,
         "5": 5360,
         "6": 9102,
         "7": 23397,
         "8": 58560,
         "9": 134668,
         "10": 329720
       },
       "totalRatings": 580103
     },
     "Females": {
       "aggregateRating": 9.3,
       "demographic": "Females",
       "histogram": {
         "1": 5781,
         "2": 912,
         "3": 1047,
         "4": 1131,
         "5": 2180,
         "6": 3577,
         "7": 9020,
         "8": 22882,
         "9": 54662,
         "10": 168975
       },
       "totalRatings": 270167
     }
   }
 }
 */
