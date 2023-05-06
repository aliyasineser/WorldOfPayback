//
//  TransactionService.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 04.05.23.
//

import Foundation
import NetworkManager

protocol TransactionService {
    func fetchTransactions() async throws -> Transactions
}

final class DefaultTransactionService: TransactionService {

    private var requestManager: RequestManager = RequestManagerFactory().make()

    public static let shared = DefaultTransactionService()

    fileprivate func fetchTestTransactions(_ request: TransactionRequest) async throws -> Transactions {
        let data = try MockDataProvider().fetchMock(for: request)
        let dataParser = DataParserFactory().make()
        let testTransactions: Transactions = try dataParser.parse(data: data)
        let delaySeconds = arc4random_uniform(2) + 1 // Generate a random number between 1 and 2
        sleep(delaySeconds) // Sleep for the random number of seconds
        return testTransactions
    }

    func fetchTransactions() async throws -> Transactions {
        let request = TransactionRequest.fetchTransactions
        guard AppEnvironment.shared.isProduction else { return try await fetchTestTransactions(request) }
        return try await requestManager.initRequest(with: request)
    }
}

class TransactionServiceFactory {
    private static let shared = DefaultTransactionService()

    static func getSharedInstance() -> TransactionService {
        shared
    }
}
