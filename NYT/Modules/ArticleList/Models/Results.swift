

import Foundation
struct Results : Decodable {
    let url : String?
    let adx_keywords : String?
    let column : String?
    let section : String?
    let byline : String?
    let type : String?
    let title : String?
    let abstract : String?
    let published_date : String?
    let source : String?
    let id : Int?
    let asset_id : Int?
    let views : Int?
    var media : [Media]?
    
    enum CodingKeys: String, CodingKey {
        
        case url = "url"
        case adx_keywords = "adx_keywords"
        case column = "column"
        case section = "section"
        case byline = "byline"
        case type = "type"
        case title = "title"
        case abstract = "abstract"
        case published_date = "published_date"
        case source = "source"
        case id = "id"
        case asset_id = "asset_id"
        case views = "views"
        case media = "media"
    }
    
    /// We need to handle special case for "media" key as it comes sometimes an Array or a String
    /// To avoid exceptions getting throwns for Type.Mismatch we need to assign default value
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        adx_keywords = try values.decodeIfPresent(String.self, forKey: .adx_keywords)
        column = try values.decodeIfPresent(String.self, forKey: .column)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        byline = try values.decodeIfPresent(String.self, forKey: .byline)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        asset_id = try values.decodeIfPresent(Int.self, forKey: .asset_id)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        if let mediaValue = try? values.decode([Media].self, forKey: .media) {
            self.media = mediaValue
        } else {
            self.media = [Media]()
        }
    }
}
