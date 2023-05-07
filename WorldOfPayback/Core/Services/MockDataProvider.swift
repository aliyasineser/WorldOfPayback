//
//  MockDataProvider.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 06.05.23.
//

import Foundation
import NetworkManager

final class MockDataProvider {

    func fetchMock(for request: NetworkRequest) throws -> Data {
        switch request {
        case is TransactionRequest:
            return try fetch(filename: "PBTransactions")
        default:
            return try fetch(filename: "invalid.filename")
        }
    }

    func fetch(filename: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw MockError.missingTestData
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            throw MockError.invalidTestData
        }
    }
}


public enum MockError: LocalizedError {
    case missingTestData
    case invalidTestData

    public var errorDescription: String? {
        switch self {
        case .missingTestData:
            return "Test Data is missing"
        case .invalidTestData:
            return "Test Data is malformed"
        }
    }
}
