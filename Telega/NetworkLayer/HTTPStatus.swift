//
//  HTTPStatus.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation

public enum HTTPStatus: Int {
    case undefined = -1
    case ok = 200
    case accepted = 202
    case badRequest = 400
    case internalServerError = 500
    case serviceUnavailable = 503

    init(statusCode: Int) {
        if let status = HTTPStatus(rawValue: statusCode) {
            self = status
        } else {
            self = .undefined
        }
    }
}
