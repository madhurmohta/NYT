

/// Genric MediaMetadata Structure
/// Supports Decodable protocol

import Foundation

struct MediaMetadata : Decodable {
	let url : String?
	let format : String?
	let height : Int?
	let width : Int?
}
