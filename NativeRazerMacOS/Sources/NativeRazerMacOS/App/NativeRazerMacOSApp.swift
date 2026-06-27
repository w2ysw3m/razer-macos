import SwiftUI

@main
struct NativeRazerMacOSApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  private let appModel = NativeAppModel.shared

  init() {
    if CommandLine.arguments.contains("--scan-hardware") {
      HardwareProbe.runAndExit()
    }
  }

  var body: some Scene {
    WindowGroup("Razer macOS Native", id: "main") {
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
        Button("About Razer macOS") {
          appModel.showAboutPanel()
        }
      }

      CommandMenu("Razer") {
        Button("Open Razer macOS") {
          appModel.showMainWindow()
        }
        .keyboardShortcut("o")

        Button("Refresh Devices") {
          appModel.refreshDevices()
        }
        .keyboardShortcut("r")

        SettingsLink()
      }
    }

    Settings {
      SettingsView()
    }
  }
}
