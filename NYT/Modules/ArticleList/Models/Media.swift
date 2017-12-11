
/// Genric Media Structure
/// Supports Decodable protocol

import Foundation
struct Media : Decodable {
	let type : String?
	let subtype : String?
	let caption : String?
	let copyright : String?
	let approved_for_syndication : Int?
	let mediaMetadata : [MediaMetadata]?

    ///Coding Keys - A type that can be used as a key for encoding and decoding.
    
	enum CodingKeys: String, CodingKey {
		case type = "type"
		case subtype = "subtype"
		case caption = "caption"
		case copyright = "copyright"
		case approved_for_syndication = "approved_for_syndication"
		case mediaMetadata = "media-metadata"
	}

    /// To conform to this protocol because we are using custom key for one param mediaMetadata
    /// If we use default keys this method implementation is not needed.
    
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
		caption = try values.decodeIfPresent(String.self, forKey: .caption)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
		approved_for_syndication = try values.decodeIfPresent(Int.self, forKey: .approved_for_syndication)
		mediaMetadata = try values.decodeIfPresent([MediaMetadata].self, forKey: .mediaMetadata)
	}

}
