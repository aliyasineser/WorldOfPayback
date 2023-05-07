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
                            Text("Transactions")
                            Image(systemName: "cart")
                        }
                    }

                SettingsView()
                    .tabItem {
                        VStack {
                            Text("Settings")
                            Image(systemName: "gear")
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)

    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
