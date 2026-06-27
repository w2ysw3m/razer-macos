import Foundation

public enum AppText {
  public static func string(_ key: AppStringKey, language: AppLanguage) -> String {
    table(for: language)[key] ?? english[key] ?? key.rawValue
  }

  public static func formatted(
    _ key: AppStringKey,
    language: AppLanguage,
    _ arguments: CVarArg...
  ) -> String {
    String(format: string(key, language: language), arguments: arguments)
  }

  public static func missingTranslations() -> [String] {
    AppLanguage.allCases.flatMap { language in
      let localizedTable = table(for: language)
      return AppStringKey.allCases.compactMap { key in
        guard localizedTable[key]?.isEmpty == false else {
          return "\(language.rawValue):\(key.rawValue)"
        }
        return nil
      }
    }
  }

  private static func table(for language: AppLanguage) -> [AppStringKey: String] {
    switch language {
    case .english:
      english
    case .simplifiedChinese:
      simplifiedChinese
    case .traditionalChinese:
      traditionalChinese
    }
  }
}
