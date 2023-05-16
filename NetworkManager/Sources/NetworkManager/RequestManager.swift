//
//  RequestManager.swift
//  
//
//  Created by Ali Yasin Eser on 04.05.23.
//

import Foundation

public protocol RequestManager {
    var apiManager: APIManager { get }
    var parser: DataParser { get }
    func initRequest<T: Decodable>(with data: NetworkRequest) async throws -> T
}

final class DefaultRequestManager: RequestManager {
    public let apiManager: APIManager

    public init(
        apiManager: APIManager = DefaultAPIManager()
    ) {
        self.apiManager = apiManager
    }

    public func initRequest<T: Decodable>(with data: NetworkRequest) async throws -> T {
        let data = try await apiManager.initRequest(with: data)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}

// MARK: - Returns Data Parser
extension RequestManager {
    public var parser: DataParser {
        return DefaultDataParser()
    }
}
