//
//  TransactionListViewModelTests.swift
//  WorldOfPaybackTests
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import XCTest
@testable import WorldOfPayback

final class TransactionListViewModelTests: XCTestCase {

    // MARK: - Variables
    private var transactionService: TransactionServiceMock!

    // MARK: - Setup
    override func setUpWithError() throws {
        transactionService = TransactionServiceMock()
        try super.setUpWithError()
    }

    // MARK: - TearDown
    override func tearDownWithError() throws {
        transactionService = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    func test_onAppear_EnvrionmentChanged_fetchTransactionIsCalled() async throws {
        // given
        AppEnvironment.shared.isProduction = true
        let sut = DefaultTransactionListModelView(transactionService: transactionService)

        // when
        AppEnvironment.shared.isProduction = false
        await sut.onAppear()

        sleep(1) // Bad use, never tested a MainActor func before so I am going to learn it soon.

        // then
        XCTAssertEqual(transactionService.fetchTransactionsCallCount, 1)
        XCTAssertEqual(sut.transactions.count, 6)
    }

    func test_transactionList_category3_only3ItemsLeft() async throws {
        // given
        let sut = DefaultTransactionListModelView(transactionService: transactionService)

        // when
        await sut.fetchTransactions()
        sut.filter = .byCategory(category: 3)
        sut.filterTransactions()

        // then
        XCTAssertEqual(transactionService.fetchTransactionsCallCount, 1)
        XCTAssertEqual(sut.transactions.count, 3)
    }

    func test_transactionList_category4_noItemsLeft() async throws {
        // given
        let sut = DefaultTransactionListModelView(transactionService: transactionService)

        // when
        await sut.fetchTransactions()
        sut.filter = .byCategory(category: 4)
        sut.filterTransactions()

        // then
        XCTAssertEqual(transactionService.fetchTransactionsCallCount, 1)
        XCTAssertEqual(sut.transactions.count, 0)
    }

    func test_transactionService_isCalled() async throws {
        // given
        let sut = DefaultTransactionListModelView(transactionService: transactionService)

        // when
        await sut.fetchTransactions()

        // then
        XCTAssertEqual(transactionService.fetchTransactionsCallCount, 1)
    }


    func test_transactionService_isThrowingNetworkError() async throws {
        // given
        let sut = DefaultTransactionListModelView(transactionService: transactionService)

        // when
        transactionService.shouldThrowNetworkError = true
        await sut.fetchTransactions()

        // then
        XCTAssertTrue(sut.isOffline)
    }

    func test_transactionService_isThrowingMockError() async throws {
        // given
        let sut = DefaultTransactionListModelView(transactionService: transactionService)

        // when
        transactionService.shouldThrowMockError = true
        await sut.fetchTransactions()

        // then
        XCTAssertTrue(sut.isDataMalformed)
    }

    func test_transactionService_isThrowingDefaultError() async throws {
        // given
        let sut = DefaultTransactionListModelView(transactionService: transactionService)

        // when
        transactionService.shouldThrowDefaultError = true
        await sut.fetchTransactions()

        // then
        XCTAssertTrue(sut.isOffline)
    }
}
