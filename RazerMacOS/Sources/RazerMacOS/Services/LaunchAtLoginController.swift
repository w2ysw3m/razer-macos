import Foundation
import Observation
import ServiceManagement
import AppKit
import NativeRazerCore

@Observable
final class LaunchAtLoginController {
  private(set) var statusMessage: AppMessage?

  var isEnabled: Bool {
    SMAppService.mainApp.status == .enabled
  }

  func statusDescription(language: AppLanguage) -> String {
    switch SMAppService.mainApp.status {
    case .enabled:
      AppText.string(.statusEnabled, language: language)
    case .notRegistered:
      AppText.string(.statusDisabled, language: language)
    case .notFound:
      AppText.string(.statusUnavailable, language: language)
    case .requiresApproval:
      AppText.string(.statusRequiresApproval, language: language)
    @unknown default:
      AppText.string(.statusUnknown, language: language)
    }
  }

  func setEnabled(_ enabled: Bool) {
    do {
      if enabled {
        if SMAppService.mainApp.status != .enabled {
          try SMAppService.mainApp.register()
        }
        statusMessage = .launchAtLoginEnabled
      } else {
        if SMAppService.mainApp.status == .enabled {
          try SMAppService.mainApp.unregister()
        }
        statusMessage = .launchAtLoginDisabled
      }
    } catch {
      statusMessage = .passthrough(error.localizedDescription)
    }
  }

  func openLoginItemsSettings() {
    guard let settingsURL = URL(string: "x-apple.systempreferences:com.apple.LoginItems-Settings.extension") else {
      return
    }

    NSWorkspace.shared.open(settingsURL)
  }
}
