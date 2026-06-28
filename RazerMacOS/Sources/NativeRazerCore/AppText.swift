import Foundation

public enum AppText {
  public static func string(_ key: AppStringKey, language: AppLanguage) -> String {
    table(for: language)[key] ?? english[key] ?? key.rawValue
  }

  public static func lightingModeName(_ mode: LightingMode, language: AppLanguage) -> String {
    switch language {
    case .english:
      mode.rawValue
    case .simplifiedChinese:
      switch mode {
      case .none:
        "关闭"
      case .staticColor:
        "静态"
      case .spectrum:
        "光谱循环"
      case .breathe:
        "呼吸"
      case .reactive:
        "响应"
      case .starlight:
        "星光"
      case .wave:
        "波浪"
      case .ripple:
        "涟漪"
      case .wheel:
        "色轮"
      case .oldMouseEffects:
        "旧版鼠标效果"
      }
    case .traditionalChinese:
      switch mode {
      case .none:
        "關閉"
      case .staticColor:
        "靜態"
      case .spectrum:
        "光譜循環"
      case .breathe:
        "呼吸"
      case .reactive:
        "反應"
      case .starlight:
        "星光"
      case .wave:
        "波浪"
      case .ripple:
        "漣漪"
      case .wheel:
        "色輪"
      case .oldMouseEffects:
        "舊版滑鼠效果"
      }
    }
  }

  public static func brightnessZoneName(_ zone: BrightnessZone, language: AppLanguage) -> String {
    switch language {
    case .english:
      zone.rawValue
    case .simplifiedChinese:
      switch zone {
      case .all:
        "全部"
      case .matrix:
        "矩阵"
      case .logo:
        "Logo"
      case .scroll:
        "滚轮"
      case .left:
        "左侧"
      case .right:
        "右侧"
      }
    case .traditionalChinese:
      switch zone {
      case .all:
        "全部"
      case .matrix:
        "矩陣"
      case .logo:
        "Logo"
      case .scroll:
        "滾輪"
      case .left:
        "左側"
      case .right:
        "右側"
      }
    }
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
