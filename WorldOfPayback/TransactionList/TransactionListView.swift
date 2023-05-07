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
                if viewModel.isOffline || viewModel.isDataMalformed {
                    VStack {
                        ErrorView(errorMessage: "Couldn't fetch the transactions.") {
                            Task {
                                try await viewModel.fetchTransactions()
                            }
                        }
                    }
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

struct ErrorView: View {
    let errorMessage: String
    let errorHandler: () -> Void

    var body: some View {
        ZStack {
            Color.red
                .opacity(0.7)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(errorMessage)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 5)

                Button(action: errorHandler) {
                    Text("Try again")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }

        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity, maxHeight: 100)
        .animation(.easeOut, value: 0.5)
    }
}
