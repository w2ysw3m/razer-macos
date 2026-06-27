import SwiftUI

struct SettingsView: View {
  @AppStorage("launchAtLogin") private var launchAtLogin = false
  @AppStorage("enableExperimentalBridge") private var enableExperimentalBridge = false

  var body: some View {
    TabView {
      Form {
        Toggle("Launch at login", isOn: $launchAtLogin)
        Toggle("Enable experimental C bridge", isOn: $enableExperimentalBridge)
      }
      .padding()
      .tabItem {
        Label("General", systemImage: "gearshape")
      }
    }
    .frame(width: 460, height: 220)
  }
}
