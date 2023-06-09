//
//  APIManager.swift
//  
//
//  Created by Ali Yasin Eser on 04.05.23.
//

import Foundation

public protocol APIManager {
    func initRequest(with data: NetworkRequest) async throws -> Data
}

final class DefaultAPIManager: APIManager {
    private let urlSession: URLSession

    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    public func initRequest(with data: NetworkRequest) async throws -> Data {
        let (data, response) = try await urlSession.data(for: data.request())
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidServerResponse
        }
        guard httpResponse.statusCode == 200 else {
            print("Error is: \(httpResponse)")
            throw NetworkError.invalidServerResponse
        }
        return data
    }
}
