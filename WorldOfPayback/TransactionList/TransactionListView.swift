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

    // MARK: - Variables

    @ObservedObject var viewModel: ViewModel

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - UI

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                if let transactions = viewModel.transactions {
                    List(transactions.items, id: \.alias.reference) {
                        TransactionItemCard(item: $0)
                    }
                }
            }
            .padding()
            .onAppear(perform: viewModel.onAppear)
            .navigationTitle("World of Payback")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: DefaultTransactionListModelView())
    }
}
