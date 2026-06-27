import NativeRazerCore
import SwiftUI

@main
struct NativeRazerMacOSApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  private let appModel = NativeAppModel.shared
  @AppStorage(AppLanguage.storageKey) private var languageRawValue = AppLanguage.english.rawValue

  init() {
    if CommandLine.arguments.contains("--scan-hardware") {
      HardwareProbe.runAndExit()
    }
  }

  private var language: AppLanguage {
    AppLanguage.stored(from: languageRawValue)
  }

  var body: some Scene {
    WindowGroup(AppText.string(.appTitle, language: language), id: "main") {
      ContentView(store: appModel.store)
        .frame(minWidth: 860, minHeight: 540)
    }

    MenuBarExtra("Razer", systemImage: "computermouse") {
      MenuBarStatusView(
        store: appModel.store,
        openMainWindow: appModel.showMainWindow,
        showAbout: appModel.showAboutPanel
      )
    }
    .commands {
      CommandGroup(replacing: .appInfo) {
        Button(AppText.string(.aboutRazerMacOS, language: language)) {
          appModel.showAboutPanel()
        }
      }

      CommandGroup(replacing: .appSettings) {
        SettingsLink {
          Text(AppText.string(.settings, language: language))
        }
      }

      CommandMenu("Razer") {
        Button(AppText.string(.openRazerMacOS, language: language)) {
          appModel.showMainWindow()
        }
        .keyboardShortcut("o")

        Button(AppText.string(.refreshDevices, language: language)) {
          appModel.refreshDevices()
        }
        .keyboardShortcut("r")

        SettingsLink {
          Text(AppText.string(.settings, language: language))
        }
      }
    }

    Settings {
      SettingsView()
    }
  }
}
