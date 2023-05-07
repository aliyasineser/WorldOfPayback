//
//  AppEnvironment.swift
//  WorldOfPayback
//
//  Created by Ali Yasin Eser on 06.05.23.
//

import Foundation

class AppEnvironment {

    // MARK: - Shared Instance
    static let shared = AppEnvironment()

    // MARK: - Variables
    private let queue = DispatchQueue(label: "com.yeser.AppEnvironmentQueue")
    private var _isProduction: Bool = true

    var isProduction: Bool {
        get {
            return queue.sync {
                _isProduction
            }
        }
        set {
            queue.async(flags: .barrier) {
                self._isProduction = newValue
            }
        }
    }

    // MARK: - Init
    private init() {}
}
