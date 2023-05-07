//
//  ContentView.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 04.05.23.
//

import SwiftUI
import Combine
import Foundation

struct TransactionListView<ViewModel>: View where ViewModel: TransactionListModelView {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if let transactions = viewModel.transactions {
                List(transactions.items, id: \.alias.reference) {
                    TransactionItemCard(item: $0)
                }

            }
        }
        .padding()
        .onAppear(perform: viewModel.onAppear)
        .navigationTitle("World Of Payback")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: DefaultTransactionListModelView())
    }
}
