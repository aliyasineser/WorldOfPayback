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
    func fetchTransactions() async throws

    var transactions: [Item] { get }
    var isOffline: Bool { get }
    var isLoading: Bool { get }
    var isDataMalformed: Bool { get }
}


final class DefaultTransactionListModelView: TransactionListModelView {

    // MARK: - Variables

    private let service = TransactionServiceFactory.getSharedInstance()

    @Published var transactions: [Item] = []
    @Published var isOffline: Bool = false
    @Published var isDataMalformed: Bool = false
    @Published var isLoading: Bool = false

    // MARK: - Functions

    @MainActor
    func onAppear() {
        Task {
            await fetchTransactions()
        }
    }

    @MainActor
    func fetchTransactions() async {
        isOffline = false
        isDataMalformed = false

        transactions = []
        isLoading = true

        do {
            transactions = try await service.fetchTransactions().items.sorted { $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate }
        } catch let error {
            handleFetchError(error)
        }

        isLoading = false
    }

    fileprivate func handleFetchError(_ error: Error) {
        isLoading = false
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
