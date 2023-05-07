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

    public static let mock: Item = Item(partnerDisplayName: "Display Name", alias: .mock, category: 1, transactionDetail: .mock)
}

// MARK: - Alias
struct Alias: Codable {
    let reference: String

    public static let mock: Alias = Alias(reference: "ReferenceNumber")
}

// MARK: - TransactionDetail
struct TransactionDetail: Codable {
    let description: Description?
    let bookingDate: Date
    let value: Value

    internal init(description: Description? = nil, bookingDate: Date, value: Value) {
        self.description = description
        self.bookingDate = bookingDate
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decodeIfPresent(Description.self, forKey: .description)

        let dateString = try container.decode(String.self, forKey: .bookingDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .bookingDate, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        self.bookingDate = date

        self.value = try container.decode(Value.self, forKey: .value)
    }

    public static let mock: TransactionDetail = TransactionDetail(description: .punkteSammeln, bookingDate: .now, value: .mock)
}

// MARK: - Description
enum Description: String, Codable {
    case punkteSammeln = "Punkte sammeln"
}

// MARK: - Value
struct Value: Codable {
    let amount: Int
    let currency: Currency

    public static let mock: Value = Value(amount: 100, currency: .pbp)
}

// MARK: - Currency
enum Currency: String, Codable {
    case pbp = "PBP"
    case eur = "EUR"

    func iconName() -> String {
        switch self {
        case .eur:
            return "eurosign"
        case .pbp:
            return "sterlingsign"
        }
    }

    func iconCharacter() -> String {
        switch self {
        case .eur:
            return "€"
        case .pbp:
            return "£"
        }
    }
}
