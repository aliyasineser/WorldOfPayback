//
//  Transactions.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 04.05.23.
//

import Foundation

// MARK: - Transactions
struct Transactions: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let partnerDisplayName: String
    let alias: Alias
    let category: Int
    let transactionDetail: TransactionDetail
}

// MARK: - Alias
struct Alias: Codable {
    let reference: String
}

// MARK: - TransactionDetail
struct TransactionDetail: Codable {
    let description: Description?
    let bookingDate: Date
    let value: Value
}

enum Description: String, Codable {
    case punkteSammeln = "Punkte sammeln"
}

// MARK: - Value
struct Value: Codable {
    let amount: Int
    let currency: Currency
}

enum Currency: String, Codable {
    case pbp = "PBP"
}
