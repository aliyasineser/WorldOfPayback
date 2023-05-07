//
//  RequestManagerMock.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import Foundation
import NetworkManager

final class RequestManagerMock: RequestManager {
    // MARK: - Variables
    var apiManager: NetworkManager.APIManager = APIManagerMock()
    var initRequestCallCount: Int = 0

    // MARK: - Functions
    func initRequest<T>(with data: NetworkManager.NetworkRequest) async throws -> T where T : Decodable {
        initRequestCallCount += 1
        return Transactions(items: [.mock]) as! T
    }
}
