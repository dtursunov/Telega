//
//  EncoderUtils.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation

struct EncoderUtils {
    static func jsonEncode(request: inout URLRequest, body: Body) throws {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonEncoded = try jsonEncoder.encode(body)
            request.httpBody = jsonEncoded
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            throw NetworkError.invalidEncodableParams
        }
    }

    static func jsonEncode(request: inout URLRequest, bodyDict: [String: Any]) throws {
        do {
            let jsonEncoded = try JSONSerialization.data(withJSONObject: bodyDict, options: .prettyPrinted)
            request.httpBody = jsonEncoded
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            throw NetworkError.invalidEncodableParams
        }
    }
    
    static func urlEncode(
        request: inout URLRequest,
        queryParams: QueryParameters,
        isNeedEncodingParams: Bool = true
    ) throws {
        guard let url = request.url else { throw NetworkError.invalidEncodableParams }
        guard !queryParams.isEmpty,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        urlComponents.queryItems = [URLQueryItem]()
        queryParams
            .compactMapValues { $0 }
            .forEach { (key: String, value: String) in
                let encodedValue: String?
                if isNeedEncodingParams {
                    encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                } else {
                    encodedValue = value
                }

                let item = URLQueryItem(name: key, value: encodedValue)
                urlComponents.queryItems?.append(item)
            }
        request.url = urlComponents.url
        request.setValue(
            "application/x-www-form-urlencoded; charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
    }
}
