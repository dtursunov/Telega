//
//  NetworkService.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation
import Network

public typealias Headers = [String: String]
public typealias QueryParameters = [String: String?]
public typealias Body = Encodable

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(path: some RequestPathProtocol) async throws -> T
    func isConnectedToNetwork() -> Bool
}

final class NetworkManager: NetworkManagerProtocol {
    /// Основной урл адресс
    private let baseURL: URL?
    private let session: URLSession
    
    init(baseURL: URL? = nil) {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        self.baseURL = baseURL
    }
    
    func fetch<T: Decodable>(path: some RequestPathProtocol) async throws -> T {
        let request = try buildRequest(path: path)
        try Task.checkCancellation()
        let result = try await execute(request: request)
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: result.data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        let pathMonitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        var isConnected = false
        pathMonitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
        }
        pathMonitor.start(queue: queue)
        return isConnected
    }
    
    private func buildRequest(path: some RequestPathProtocol) throws -> URLRequest {
        var url: URL?
        if let baseURL {
            url = baseURL.appendingPathComponent(path.urlPath)
        } else if let pathUrl = URL(string: path.urlPath) {
            url = pathUrl
        }
        guard let url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        request.httpMethod = path.method.rawValue
        
        if let queryParams = path.queryParams {
            do {
                try EncoderUtils.urlEncode(
                    request: &request,
                    queryParams: queryParams
                )
            } catch {
                throw error
            }
        }
    
        do {
            try path.body?.setBodyInRequest(&request)
        } catch {
            throw error
        }

        return request
    }
    
    private func execute(request: URLRequest) async throws -> (data: Data, response: HTTPStatus) {
        do {
            try Task.checkCancellation()
        } catch {
            throw error
        }
        let result: (data: Data, response: URLResponse) = try await session.data(for: request)
        guard let httpResponse = result.response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        let responseStatus = HTTPStatus(rawValue: httpResponse.statusCode) ?? .undefined
        return (result.data, responseStatus)
    }
}
