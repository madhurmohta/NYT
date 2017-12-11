

/// Genric Base Structure
/// Supports Decodable protocol
import Foundation

struct Base: Decodable {
    let status : String?
    let copyright : String?
    let num_results : Int?
    let results : [Results]?    
}
