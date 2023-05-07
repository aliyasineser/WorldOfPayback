//
//  SettingsView.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 07.05.23.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - Enum
    private enum Envrionments: String, CaseIterable, Identifiable {
        case production, test
        var id: Self { self }
    }

    // MARK: - Variables
    @State private var selectedEnvironment: Envrionments = .test

    // MARK: - UI
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Picker(L10n.settingsPickerEnvironment, selection: $selectedEnvironment) {
                        Text(L10n.settingsPickerEnvProduction).tag(Envrionments.production)
                        Text(L10n.settingsPickerEnvTest).tag(Envrionments.test)
                    }
                    .onChange(of: selectedEnvironment) { _ in updateEnvironment() }

                }
            }
            .navigationTitle(L10n.settingsViewNavigationTitle)
        }
    }

    // MARK: - Functions
    fileprivate func updateEnvironment() {
        AppEnvironment.shared.isProduction = selectedEnvironment == .production ? true : false
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
