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
    func onLoad()
    func filterTransactions()
    func fetchTransactions() async throws

    var filter: TransactionsFilter { get set }
    var transactions: [Item] { get }
    var sumOfTransactions: Double { get }
    var sumOfTransactionsText: String { get }
    var isOffline: Bool { get }
    var isLoading: Bool { get }
    var isDataMalformed: Bool { get }
}

final class DefaultTransactionListModelView: TransactionListModelView {

    // MARK: - Variables

    private let transactionService: TransactionService
    private var wasLastEnvProduction = false

    private var unfilteredTransactions: [Item] = []
    @Published var filter: TransactionsFilter = .none
    @Published var transactions: [Item] = []
    @Published var sumOfTransactions: Double = 0.0
    @Published var isOffline: Bool = false
    @Published var sumOfTransactionsText: String = ""
    @Published var isDataMalformed: Bool = false
    @Published var isLoading: Bool = false

    init(
        transactionService: TransactionService = TransactionServiceFactory.make()
    ) {
        self.transactionService = transactionService
        self.wasLastEnvProduction = AppEnvironment.shared.isProduction
    }

    // MARK: - Functions

    @MainActor
    func onLoad() {
        Task {
            await fetchTransactions()
        }
    }

    @MainActor
    func onAppear() {
        guard wasLastEnvProduction != AppEnvironment.shared.isProduction else { return }
        wasLastEnvProduction = AppEnvironment.shared.isProduction
        Task {
            await fetchTransactions()
        }
    }

    @MainActor
    func fetchTransactions() async {
        isOffline = false
        isDataMalformed = false

        unfilteredTransactions = []
        transactions = []
        isLoading = true

        do {
            let fetchedTransactions = try await transactionService.fetchTransactions().items
            unfilteredTransactions = fetchedTransactions.sorted { $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate }
            filterTransactions()
            calculateSumOfTransactions()
        } catch let error {
            handleFetchError(error)
        }

        isLoading = false
    }

    private func calculateSumOfTransactions() {
        guard let firstItem = transactions.first else { return } // Both transaction empty check and helps to get the currency
        sumOfTransactions = transactions.map{ Double($0.transactionDetail.value.amount) }.reduce(0, +)
        sumOfTransactionsText = "\(L10n.transactionSum): " + sumOfTransactions.description + " " + firstItem.transactionDetail.value.currency.iconCharacter()
    }

    func filterTransactions() {
        switch filter {
        case .none:
            transactions = unfilteredTransactions
        case .byCategory(let category):
            transactions = unfilteredTransactions.filter {$0.category == category}
        }
        calculateSumOfTransactions()
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
