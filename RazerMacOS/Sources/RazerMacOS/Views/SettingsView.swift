import NativeRazerCore
import SwiftUI

struct SettingsView: View {
  @State private var launchAtLogin = LaunchAtLoginController()
  @AppStorage(AppLanguage.storageKey) private var languageRawValue = AppLanguage.english.rawValue

  private var language: AppLanguage {
    AppLanguage.stored(from: languageRawValue)
  }

  var body: some View {
    TabView {
      Form {
        Picker(AppText.string(.language, language: language), selection: $languageRawValue) {
          ForEach(AppLanguage.allCases) { appLanguage in
            Text(appLanguage.displayName).tag(appLanguage.rawValue)
          }
        }
        LabeledContent(AppText.string(.runtime, language: language), value: "SwiftUI/AppKit")
        LabeledContent(AppText.string(.deviceBridge, language: language), value: "librazermacos")
        Toggle(
          AppText.string(.launchAtLogin, language: language),
          isOn: Binding(
            get: { launchAtLogin.isEnabled },
            set: { launchAtLogin.setEnabled($0) }
          )
        )
        LabeledContent(
          AppText.string(.launchAtLoginStatus, language: language),
          value: launchAtLogin.statusDescription(language: language)
        )
        LabeledContent(
          AppText.string(.statusBar, language: language),
          value: AppText.string(.statusBarAlwaysOn, language: language)
        )
        LabeledContent(
          AppText.string(.signing, language: language),
          value: AppText.string(.signingPlanned, language: language)
        )

        Button(AppText.string(.openLoginItemsSettings, language: language)) {
          launchAtLogin.openLoginItemsSettings()
        }

        Text(AppText.string(.launchAtLoginHelp, language: language))
        .font(.caption)
        .foregroundStyle(.secondary)

        if let statusMessage = launchAtLogin.statusMessage {
          Text(statusMessage.localized(language: language))
            .font(.caption)
            .foregroundStyle(.secondary)
        }
      }
      .padding()
      .tabItem {
        Label(AppText.string(.general, language: language), systemImage: "gearshape")
      }
    }
    .frame(width: 520, height: 320)
  }
}
