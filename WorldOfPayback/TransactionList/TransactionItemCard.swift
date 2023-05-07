//
//  TransactionItem.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 06.05.23.
//

import SwiftUI

struct TransactionItemCard: View {

    // MARK: - Variables

    private let item: Item

    // MARK: - Init

    init(item: Item) {
        self.item = item
    }

    // MARK: - UI

    var body: some View {
        HStack {
            VStack {
                Text(item.partnerDisplayName)
                    .font(.title2)
                    .padding(.bottom, 10)
                if let description = item.transactionDetail.description {
                    Text(description.rawValue)
                }
            }
            Spacer()
            VStack {
                Text(item.transactionDetail.bookingDate.formatted(date: .abbreviated, time: .omitted))
                    .padding(.bottom, 10)
                HStack(spacing: 1) {
                    Text(item.transactionDetail.value.amount.description)
                        .font(.title2)
                    Image(systemName: item.transactionDetail.value.currency.iconName())
                }
            }
        }

    }
}

struct TransactionItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItemCard(item: .mock)
    }
}
