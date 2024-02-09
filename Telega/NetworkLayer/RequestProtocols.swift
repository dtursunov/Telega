//
//  RequestProtocols.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation

protocol RequestPathProtocol {
    var urlPath: String { get }
    var method: HTTPMethod { get }
    var body: BodyTypeRequest? { get }
    var queryParams: QueryParameters? { get }
}
