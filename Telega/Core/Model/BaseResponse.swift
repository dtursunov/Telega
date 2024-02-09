import Foundation

struct BookResponse: Decodable {
    let kind: String?
    let totalItems: Int?
    let items: [BookItemDTO]?
}
