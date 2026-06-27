import NativeRazerCore
import SwiftUI

struct ContentView: View {
  @Bindable var store: NativeDeviceStore
  @AppStorage(AppLanguage.storageKey) private var languageRawValue = AppLanguage.english.rawValue

  private var language: AppLanguage {
    AppLanguage.stored(from: languageRawValue)
  }

  var body: some View {
    NavigationSplitView {
      SidebarView(
        devices: store.devices,
        selection: $store.selectedDeviceId
      )
    } detail: {
      DetailView(store: store)
    }
    .environment(\.appLanguage, language)
    .navigationTitle(AppText.string(.appTitle, language: language))
  }
}
