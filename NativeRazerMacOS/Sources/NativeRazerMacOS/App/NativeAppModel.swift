import AppKit
import SwiftUI

@MainActor
final class NativeAppModel {
  static let shared = NativeAppModel()

  let store = NativeDeviceStore()
  private var mainWindow: NSWindow?

  private init() {}

  func showMainWindow() {
    if let existingWindow = NSApp.windows.first(where: { $0.title == "Razer macOS Native" }) {
      existingWindow.makeKeyAndOrderFront(nil)
      NSApp.activate(ignoringOtherApps: true)
      return
    }

    let window = mainWindow ?? makeMainWindow()
    mainWindow = window

    if !window.isVisible {
      window.center()
    }
    window.makeKeyAndOrderFront(nil)
    NSApp.activate(ignoringOtherApps: true)
  }

  func refreshDevices() {
    store.refresh()
  }

  func shutdown() {
    store.shutdown()
  }

  private func makeMainWindow() -> NSWindow {
    let rootView = ContentView(store: store)
      .frame(minWidth: 860, minHeight: 540)

    let window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 960, height: 680),
      styleMask: [.titled, .closable, .miniaturizable, .resizable],
      backing: .buffered,
      defer: false
    )
    window.title = "Razer macOS Native"
    window.contentView = NSHostingView(rootView: rootView)
    window.isReleasedWhenClosed = false
    window.setFrameAutosaveName("NativeRazerMacOSMainWindow")
    return window
  }
}
