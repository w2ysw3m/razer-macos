import Foundation
import Observation
import ServiceManagement

@Observable
final class LaunchAtLoginController {
  private(set) var statusMessage: String = ""

  var isEnabled: Bool {
    SMAppService.mainApp.status == .enabled
  }

  func setEnabled(_ enabled: Bool) {
    do {
      if enabled {
        if SMAppService.mainApp.status != .enabled {
          try SMAppService.mainApp.register()
        }
        statusMessage = "Launch at login is enabled."
      } else {
        if SMAppService.mainApp.status == .enabled {
          try SMAppService.mainApp.unregister()
        }
        statusMessage = "Launch at login is disabled."
      }
    } catch {
      statusMessage = error.localizedDescription
    }
  }
}
