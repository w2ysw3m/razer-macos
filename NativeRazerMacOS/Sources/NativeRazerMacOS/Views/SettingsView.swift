import SwiftUI

struct SettingsView: View {
  var body: some View {
    TabView {
      Form {
        LabeledContent("Runtime", value: "SwiftUI/AppKit")
        LabeledContent("Device bridge", value: "Planned")
        LabeledContent("Signing", value: "Planned")
      }
      .padding()
      .tabItem {
        Label("General", systemImage: "gearshape")
      }
    }
    .frame(width: 420, height: 180)
  }
}
