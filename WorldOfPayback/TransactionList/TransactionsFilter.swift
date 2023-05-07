//
//  TransactionsFilter.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import Foundation

enum TransactionsFilter: Hashable, Equatable {
    case none
    case byCategory(category: Int)
}
