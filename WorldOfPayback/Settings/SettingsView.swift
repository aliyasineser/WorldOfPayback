//
//  SettingsView.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import SwiftUI




struct SettingsView: View {

    enum Envrionments: String, CaseIterable, Identifiable {
        case production, test
        var id: Self { self }
    }

    @State private var selectedEnvironment: Envrionments = .test


    fileprivate func updateEnvironment() {
        AppEnvironment.shared.isProduction = selectedEnvironment == .production ? true : false
    }

    var body: some View {
        List {
            HStack {
                Picker("Environment", selection: $selectedEnvironment) {
                    Text("Production").tag(Envrionments.production)
                    Text("Test").tag(Envrionments.test)
                }
                .onChange(of: selectedEnvironment) { _ in updateEnvironment() }

            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
