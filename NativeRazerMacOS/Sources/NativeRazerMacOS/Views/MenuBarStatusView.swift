import AppKit
import NativeRazerCore
import SwiftUI

struct MenuBarStatusView: View {
  let store: NativeDeviceStore
  let openMainWindow: () -> Void
  let showAbout: () -> Void
  @AppStorage(AppLanguage.storageKey) private var languageRawValue = AppLanguage.english.rawValue

  private var language: AppLanguage {
    AppLanguage.stored(from: languageRawValue)
  }

  var body: some View {
    Button(AppText.string(.openRazerMacOS, language: language)) {
      openMainWindow()
    }

    Button(AppText.string(.refreshDevices, language: language)) {
      store.refresh()
    }

    Divider()

    if store.statusBarDevices.isEmpty {
      Text(AppText.string(.noRazerMouse, language: language))
    } else {
      ForEach(store.statusBarDevices) { device in
        Button(device.name) {
          openMainWindow()
        }
        .disabled(true)

        if let dpi = device.controlState.dpi {
          Text(AppText.formatted(.dpiMenu, language: language, dpi))
        }

        if let pollingRate = device.controlState.pollingRate {
          Text(AppText.formatted(.rateMenu, language: language, pollingRate))
        }

        if let batteryLevel = device.controlState.batteryLevel {
          Text(AppText.formatted(.batteryMenu, language: language, batteryLevel))
        }
      }
    }

    Divider()

    Text(store.lastRefreshSummary.localized(language: language))

    Divider()

    SettingsLink {
      Text(AppText.string(.settings, language: language))
    }

    Button(AppText.string(.aboutRazerMacOS, language: language)) {
      showAbout()
    }

    Button(AppText.string(.quit, language: language)) {
      NSApplication.shared.terminate(nil)
    }
    .keyboardShortcut("q")
  }
}
