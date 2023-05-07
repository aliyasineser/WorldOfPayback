//
//  TransactionServiceMock.swift
//  WorldOfPaybackTests
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import Foundation
import NetworkManager

final class TransactionServiceMock: TransactionService {
    // MARK: - Variables
    var fetchTransactionsCallCount: Int = 0
    var shouldThrowNetworkError: Bool = false
    var shouldThrowMockError: Bool = false
    var shouldThrowDefaultError: Bool = false // to trigger default in catch statement, for coverage

    // MARK: - Functions
    func fetchTransactions() async throws -> Transactions {
        fetchTransactionsCallCount += 1
        if shouldThrowNetworkError { throw NetworkError.invalidURL }
        if shouldThrowMockError { throw MockError.missingTestData }
        if shouldThrowDefaultError { throw TransactionMockError.defaultError }
        return Transactions(
            items: [
                .mock(withCategory: 1),
                .mock(withCategory: 2),
                .mock(withCategory: 2),
                .mock(withCategory: 3),
                .mock(withCategory: 3),
                .mock(withCategory: 3)
            ]
        )
    }
}

// MARK: - Error Type
enum TransactionMockError: Error {
    case defaultError
}
