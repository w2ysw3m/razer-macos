public enum MigrationStage: String, CaseIterable, Identifiable, Sendable {
  case nativeShell = "Native shell"
  case cBridge = "C bridge"
  case deviceControls = "Device controls"
  case packaging = "Packaging"

  public var id: String { rawValue }

  public var summary: String {
    switch self {
    case .nativeShell:
      "SwiftUI/AppKit app shell with macOS window, settings, and run loop."
    case .cBridge:
      "Swift module boundary for librazermacos and IOKit/HID calls."
    case .deviceControls:
      "Native controls for DPI, polling rate, and hardware status."
    case .packaging:
      "Signing, hardened runtime, notarization, and permission copy."
    }
  }
}
