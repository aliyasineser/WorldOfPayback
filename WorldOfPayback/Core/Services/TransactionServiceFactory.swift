//
//  TransactionServiceFactory.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import Foundation
import NetworkManager

// MARK: - Factory
class TransactionServiceFactory {
    static func make(
        requestManager: RequestManager = RequestManagerFactory().make()
    ) -> TransactionService {
        DefaultTransactionService(requestManager: requestManager)
    }
}
