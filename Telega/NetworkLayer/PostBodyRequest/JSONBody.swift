//
//  JSONBody.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation

public class JSONBody: BodyTypeRequest {
    enum BodyType {
        case dict([String: Any])
        case body(Body)
    }

    private let body: BodyType

    public init(body: Body) {
        self.body = .body(body)
    }

    public init(body: [String: Any]) {
        self.body = .dict(body)
    }

    public func setBodyInRequest(_ request: inout URLRequest) throws {
        switch body {
        case let .body(body):
            try EncoderUtils.jsonEncode(request: &request, body: body)
        case let .dict(dict):
            try EncoderUtils.jsonEncode(request: &request, bodyDict: dict)
        }
    }
}
