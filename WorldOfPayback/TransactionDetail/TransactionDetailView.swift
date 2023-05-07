//
//  TransactionDetailView.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import SwiftUI

struct TransactionDetailView: View {

    // MARK: - Variables
    private let item: Item

    // MARK: - Init
    init(item: Item) {
        self.item = item
    }

    // MARK: - UI
    var body: some View {
        VStack(spacing: 20) {
            Text(item.partnerDisplayName)
                .font(.largeTitle)
            if let description = item.transactionDetail.description {
                Text(description.rawValue)
                    .font(.title3)
            }
        }
    }
}

// MARK: - Preview
struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(item: .mock)
    }
}
