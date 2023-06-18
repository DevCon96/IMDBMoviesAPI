
/* action|adventure|animation|biography|comedy|crime|documentary|drama|family|fantasy|film-noir|game-show||history|horror|music|musical|mystery|news|reality-tv|romance|sci-fi|short|sport|talk-show|thriller|war|western
 */

public enum Genre: String, CaseIterable, Identifiable {
    public var id: Self { self }

    case action = "action"
    case adventure = "adventure"
    case animation = "animation"
    case biography = "biography"
    case comedy = "comedy"
    case crime = "crime"
    case documentary = "documentary"
    case drama = "drama"
    case family = "family"
    case fantasy = "fantasy"
    case filmNoir = "film-noir"
    case gameShow = "game-show"
    case history = "history"
    case horror = "horror"
    case music = "music"
    case musical = "musical"
    case mystery = "mystery"
    case news = "news"
    case realityTv = "reality-tv"
    case romance = "romance"
    case scifi = "sci-fi"
    case short = "short"
    case sport = "sport"
    case talkShow = "talk-show"
    case thriller = "thriller"
    case war = "war"
    case western = "western"
    case unknown = ""
}

