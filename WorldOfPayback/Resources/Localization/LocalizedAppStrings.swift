// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Try again
  internal static let errorViewTryAgain = L10n.tr("Localizable", "ErrorViewTryAgain", fallback: "Try again")
  /// Category %d
  internal static func pickerFilterCategory(_ p1: Int) -> String {
    return L10n.tr("Localizable", "PickerFilterCategory", p1, fallback: "Category %d")
  }
  /// Show All
  internal static let pickerFilterOptionShowAll = L10n.tr("Localizable", "PickerFilterOptionShowAll", fallback: "Show All")
  /// Filter
  internal static let pickerFilterTitle = L10n.tr("Localizable", "PickerFilterTitle", fallback: "Filter")
  /// Environment
  internal static let settingsPickerEnvironment = L10n.tr("Localizable", "SettingsPickerEnvironment", fallback: "Environment")
  /// Production
  internal static let settingsPickerEnvProduction = L10n.tr("Localizable", "SettingsPickerEnvProduction", fallback: "Production")
  /// Test
  internal static let settingsPickerEnvTest = L10n.tr("Localizable", "SettingsPickerEnvTest", fallback: "Test")
  /// Settings
  internal static let settingsTabTitle = L10n.tr("Localizable", "SettingsTabTitle", fallback: "Settings")
  /// Settings
  internal static let settingsViewNavigationTitle = L10n.tr("Localizable", "SettingsViewNavigationTitle", fallback: "Settings")
  /// Localizable.strings
  ///   WorldOfPayback
  /// 
  ///   Created by Ali Yasin Eser on 07.05.23.
  internal static let transactionFetchErrorMessage = L10n.tr("Localizable", "TransactionFetchErrorMessage", fallback: "Couldn't fetch the transactions.")
  /// World of Payback
  internal static let transactionListViewNavigationTitle = L10n.tr("Localizable", "TransactionListViewNavigationTitle", fallback: "World of Payback")
  /// Transactions
  internal static let transactionsTabTitle = L10n.tr("Localizable", "TransactionsTabTitle", fallback: "Transactions")
  /// Sum
  internal static let transactionSum = L10n.tr("Localizable", "TransactionSum", fallback: "Sum")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
