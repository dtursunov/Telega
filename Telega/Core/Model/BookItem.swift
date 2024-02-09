//
//  BookItem.swift
//  Telega
//
//  Created by Diyor Tursunov on 09/02/24.
//

import Foundation

struct BookItem {
    let id: String
    let name: String
    let authors: String?
    let detail: String?
    let imageURL: String?
    let publishedYear: String?
    
    init(book: BookItemDTO) {
        id = book.id ?? ""
        name = book.volumeInfo?.title ?? ""
        authors = book.volumeInfo?.authors?.joined(separator: "\n")
        detail = book.volumeInfo?.subtitle
        imageURL = book.volumeInfo?.imageLinks?.medium
        publishedYear = book.volumeInfo?.publishedDate
    }
    
    init(book: BookEntityModel) {
        id = book.id ?? ""
        name = book.name ?? ""
        authors = book.authors
        detail = book.detail
        imageURL = book.imageURL
        publishedYear = book.publishedYear
    }
}
