import SwiftUI

struct SettingsView: View {
  @State private var launchAtLogin = LaunchAtLoginController()

  var body: some View {
    TabView {
      Form {
        LabeledContent("Runtime", value: "SwiftUI/AppKit")
        LabeledContent("Device bridge", value: "librazermacos")
        Toggle(
          "Launch at login",
          isOn: Binding(
            get: { launchAtLogin.isEnabled },
            set: { launchAtLogin.setEnabled($0) }
          )
        )
        LabeledContent("Status bar", value: "Always on")
        LabeledContent("Signing", value: "Planned")

        if !launchAtLogin.statusMessage.isEmpty {
          Text(launchAtLogin.statusMessage)
            .font(.caption)
            .foregroundStyle(.secondary)
        }
      }
      .padding()
      .tabItem {
        Label("General", systemImage: "gearshape")
      }
    }
    .frame(width: 460, height: 240)
  }
}
