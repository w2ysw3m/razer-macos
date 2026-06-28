public enum AppLanguage: String, CaseIterable, Identifiable, Sendable {
  case english = "en"
  case simplifiedChinese = "zh-Hans"
  case traditionalChinese = "zh-Hant"

  public static let storageKey = "appLanguage"

  public var id: String { rawValue }

  public var displayName: String {
    switch self {
    case .english:
      "English"
    case .simplifiedChinese:
      "简体中文"
    case .traditionalChinese:
      "繁體中文"
    }
  }

  public static func stored(from rawValue: String?) -> AppLanguage {
    guard let rawValue,
          let language = AppLanguage(rawValue: rawValue)
    else {
      return .english
    }
    return language
  }
}
