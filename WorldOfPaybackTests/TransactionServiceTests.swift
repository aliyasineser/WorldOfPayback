//
//  TransactionServiceTests.swift
//  WorldOfPaybackTests
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import XCTest
@testable import WorldOfPayback

final class TransactionServiceTests: XCTestCase {

    private var requestManager: RequestManagerMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        requestManager = RequestManagerMock()
    }

    override func tearDownWithError() throws {
        requestManager = nil
        try super.tearDownWithError()
    }

    func test_ProductionEnv_fetchTransactionCalled_RequestManagerCalledOnce() async throws {
        // given
        AppEnvironment.shared.isProduction = true

        // when
        let sut = TransactionServiceFactory.make(requestManager: requestManager)
        _ = try await sut.fetchTransactions()

        // then
        XCTAssertEqual(requestManager.initRequestCallCount, 1)
    }

    func test_TestEnv_fetchTransactionCalled_RequestManagerIsNeverCalled() async throws {
        // given
        AppEnvironment.shared.isProduction = false

        // when
        let sut = TransactionServiceFactory.make(requestManager: requestManager)
        _ = try await sut.fetchTransactions()

        // then
        XCTAssertEqual(requestManager.initRequestCallCount, 0)
    }
}
