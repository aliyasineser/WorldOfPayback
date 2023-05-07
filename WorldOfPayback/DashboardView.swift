//
//  DashboardView.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import SwiftUI

struct DashboardView: View {

    // MARK: - UI
    var body: some View {

        TabView {
            TransactionListView(viewModel: DefaultTransactionListModelView())
                .tabItem {
                    VStack {
                        Text(L10n.transactionsTabTitle)
                        Image(systemName: "cart")
                    }
                }

            SettingsView()
                .tabItem {
                    VStack {
                        Text(L10n.settingsTabTitle)
                        Image(systemName: "gear")
                    }
                }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
    }
}

// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
