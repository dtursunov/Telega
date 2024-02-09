//
//  BaseRequest.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation

struct BaseRequest: RequestPathProtocol {
    let urlPath: String
    var method: HTTPMethod = .get
    var body: BodyTypeRequest? = nil
    var queryParams: QueryParameters?

    init(query: String) {
        urlPath = "/books/v1/volumes"
        queryParams = [
            "q": query,
        ]
    }
}
