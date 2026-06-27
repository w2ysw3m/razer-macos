import SwiftUI

@main
struct NativeRazerMacOSApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  @State private var store = NativeDeviceStore()

  var body: some Scene {
    WindowGroup("Razer macOS Native", id: "main") {
      ContentView(store: store)
        .frame(minWidth: 860, minHeight: 540)
    }
    .commands {
      CommandMenu("Razer") {
        Button("Refresh Devices") {
          store.refresh()
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
