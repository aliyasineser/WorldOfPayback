//
//  WorldOfPaybackApp.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 04.05.23.
//

import SwiftUI

@main
struct WorldOfPaybackApp: App {

    // MARK: - Init

    init() {
        AppEnvironment.shared.isProduction = false // Assuming JSON read case, can be changed in the app
    }

    // MARK: - Scene

    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
}
