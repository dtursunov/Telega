//
//  BookItemDTO.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation

struct BookItemDTO: Decodable {
    let id: String?
    let volumeInfo: VolumeInfoDTO?
    let kind: String?
    let etag: String?
    let selfLink: String?
}


struct VolumeInfoDTO: Decodable {
    let title: String?
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let pageCount: Int?
    let printedPageCount: Int?
    let printType: String?
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
}

struct ImageLinks: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
    let small: String?
    let medium: String?
    let large: String?
    let extraLarge: String?
}

