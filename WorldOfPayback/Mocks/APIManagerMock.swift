//
//  APIManagerMock.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import Foundation
import NetworkManager

final class APIManagerMock: APIManager {
    // MARK: - Variables
    var initRequestCallCount: Int = 0

    // MARK: - Functions
    func initRequest(with data: NetworkManager.NetworkRequest) async throws -> Data {
        initRequestCallCount += 1
        return Data()
    }

}
