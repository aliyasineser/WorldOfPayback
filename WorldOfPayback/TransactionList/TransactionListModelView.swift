//
//  TransactionListModelView.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 06.05.23.
//

import Foundation
import NetworkManager

protocol TransactionListModelView: ObservableObject {
    func onAppear()

    var transactions: Transactions? { get }
    var isOffline: Bool { get }
    var isLoading: Bool { get }
    var isDataMalformed: Bool { get }
}


final class DefaultTransactionListModelView: TransactionListModelView {

    // MARK: - Variables

    private let service = TransactionServiceFactory.getSharedInstance()

    @Published var transactions: Transactions?
    @Published var isOffline: Bool = false
    @Published var isDataMalformed: Bool = false
    @Published var isLoading: Bool = false

    // MARK: - Functions

    @MainActor
    func onAppear() {
        Task {
            do {
                try await refetchTransactions()
            } catch let error {
                handleFetchError(error)
            }
        }
    }

    @MainActor
    func refetchTransactions() async throws {
        transactions = nil
        isLoading = true
        transactions = try await service.fetchTransactions()
        isLoading = false
    }

    fileprivate func handleFetchError(_ error: Error) {
        switch error {
        case is NetworkError:
            isOffline = true
        case is MockError:
            isDataMalformed = true
        default:
            isOffline = true
        }
    }

}
