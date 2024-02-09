//
//  NetworkError.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case invalidEncodableParams
    case noInternetConnection
    case other(Error)
}
