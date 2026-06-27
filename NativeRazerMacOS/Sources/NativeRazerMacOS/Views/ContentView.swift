import NativeRazerCore
import SwiftUI

struct ContentView: View {
  @Bindable var store: NativeDeviceStore

  var body: some View {
    NavigationSplitView {
      SidebarView(
        devices: store.devices,
        selection: $store.selectedDeviceId
      )
    } detail: {
      DetailView(store: store)
    }
    .navigationTitle("Razer macOS Native")
  }
}
