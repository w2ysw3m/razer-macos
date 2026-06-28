import NativeRazerCore
import SwiftUI

private struct AppLanguageEnvironmentKey: EnvironmentKey {
  static let defaultValue = AppLanguage.english
}

extension EnvironmentValues {
  var appLanguage: AppLanguage {
    get { self[AppLanguageEnvironmentKey.self] }
    set { self[AppLanguageEnvironmentKey.self] = newValue }
  }
}
