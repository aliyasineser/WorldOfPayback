//
//  TransactionRequest.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 04.05.23.
//

import Foundation
import NetworkManager

enum TransactionRequest: NetworkRequest {
    case fetchTransactions

    var host: String {
        APIConstants.baseURL
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var params: [String : Any] {
        [:]
    }
    
    var urlParams: [String : String?] {
        [:]
    }
    
    var addAuthorizationToken: Bool {
        false
    }

    var path: String {
        switch self {
        case .fetchTransactions:
            return "/transactions"
        }
    }

    var requestType: RequestType {
        switch self {
        case .fetchTransactions:
            return .GET
        }
    }
}
