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

    private var isLoadedAndSuccessful: Bool {
        !(viewModel.isOffline || viewModel.isDataMalformed) && !viewModel.isLoading
    }

    private var isErrorReceived: Bool {
        (viewModel.isOffline || viewModel.isDataMalformed)
    }

    private var isLoading: Bool { viewModel.isLoading }

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - UI

    var body: some View {
        NavigationView {
            VStack {
                if isLoading { ProgressView() }
                if isErrorReceived { errorView }
                if isLoadedAndSuccessful { categoryPickerView }
                transactionListView
                Spacer()
                Divider()
                if isLoadedAndSuccessful { sumOfTransactionsView }
            }
            .padding()
            .onAppear(perform: viewModel.onAppear)
            .navigationTitle("World of Payback")
        }
    }

    private var categoryPickerView: some View {
        // Review Note: This section can be written better if the category logic is explained
        // The solution is based on what I see in the JSON mocked response
        Picker("Filter", selection: $viewModel.filter) {
            Text("Show All").tag(TransactionsFilter.none)
            Text("Category 1").tag(TransactionsFilter.byCategory(category: 1))
            Text("Category 2").tag(TransactionsFilter.byCategory(category: 2))
            Text("Category 3").tag(TransactionsFilter.byCategory(category: 3))
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.filter) { _ in viewModel.filterTransactions() }
    }

    private var transactionListView: some View {
        List(
            viewModel.transactions,
            id: \.alias.reference
        ) { item in
            NavigationLink {
                TransactionDetailView(item: item)
            } label: {
                TransactionItemCard(item: item)
            }
        }
        .listStyle(.plain)
    }

    private var sumOfTransactionsView: some View {
        Text(viewModel.sumOfTransactionsText)
    }

    private var errorView: some View {
        VStack {
            ErrorView(errorMessage: L10n.transactionFetchErrorMessage) {
                Task {
                    try await viewModel.fetchTransactions()
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: DefaultTransactionListModelView())
    }
}

