import Foundation
import NativeRazerCore
import Observation

@Observable
final class NativeDeviceStore {
  private let inventory: MigrationInventory
  private let hardwareController: NativeRazerHardwareControlling
  private(set) var devices: [NativeDevice]
  private(set) var stages: [MigrationStage]
  var selectedDeviceId: NativeDevice.ID?
  var lastRefreshSummary: AppMessage

  init(
    inventory: MigrationInventory = MigrationInventory(),
    hardwareController: NativeRazerHardwareControlling = NativeRazerHardwareController()
  ) {
    self.inventory = inventory
    self.hardwareController = hardwareController
    self.devices = inventory.devices
    self.stages = inventory.stages
    self.selectedDeviceId = inventory.primaryDevice?.id ?? inventory.devices.first?.id
    self.lastRefreshSummary = .readyToBridge(path: inventory.bridgeSourcePath)
    refresh()
  }

  var selectedDevice: NativeDevice? {
    guard let selectedDeviceId else {
      return devices.first
    }
    return devices.first { device in
      device.id == selectedDeviceId
    }
  }

  var bridgeSourcePath: String {
    inventory.bridgeSourcePath
  }

  var supportedCapabilityCount: Int {
    inventory.supportedCapabilityCount
  }

  func refresh() {
    let hardwareMice = hardwareController.refreshMice()
    devices = inventory.devices.map { device in
      guard let hardwareMouse = hardwareMice.first(where: { $0.productId == device.productId }) else {
        var previewDevice = device
        previewDevice.hardwareInternalId = nil
        previewDevice.setBridgeStatus(.controlsPreviewHardwareNotMatched)
        return previewDevice
      }

      var connectedDevice = device
      let readSucceeded = hardwareMouse.dpi > 0 || hardwareMouse.pollingRate > 0
      connectedDevice.connection = "librazermacos internal #\(hardwareMouse.internalDeviceId)"
      connectedDevice.hardwareInternalId = hardwareMouse.internalDeviceId
      connectedDevice.setBridgeStatus(readSucceeded ? .connected : .detectedReadTimedOut)
      connectedDevice.controlState.dpi = normalizedDPI(hardwareMouse.dpi, fallback: device.controlState.dpi)
      connectedDevice.controlState.pollingRate = normalizedPollingRate(
        hardwareMouse.pollingRate,
        fallback: device.controlState.pollingRate
      )
      connectedDevice.controlState.batteryLevel = hardwareMouse.batteryLevel
      connectedDevice.controlState.isCharging = hardwareMouse.isCharging
      return connectedDevice
    }
    stages = inventory.stages
    selectedDeviceId = selectedDevice?.id ?? inventory.primaryDevice?.id
    lastRefreshSummary = hardwareMice.isEmpty
      ? .targetLoadedNoLiveMouse(count: devices.count)
      : .liveMouseLoaded(count: hardwareMice.count)
  }

  func setDPI(_ dpi: Int) {
    guard let device = selectedDevice else {
      return
    }

    let result = hardwareController.setDPI(dpi, internalDeviceId: device.hardwareInternalId)
    updateSelectedDevice { selected in
      selected.controlState.dpi = dpi
      selected.setBridgeStatus(statusText(for: result))
    }
    lastRefreshSummary = summaryText(action: "DPI \(dpi)", result: result)
  }

  func setPollingRate(_ pollingRate: Int) {
    guard let device = selectedDevice else {
      return
    }

    let result = hardwareController.setPollingRate(
      pollingRate,
      internalDeviceId: device.hardwareInternalId
    )
    updateSelectedDevice { selected in
      selected.controlState.pollingRate = pollingRate
      selected.setBridgeStatus(statusText(for: result))
    }
    lastRefreshSummary = summaryText(action: "\(pollingRate) Hz", result: result)
  }

  func shutdown() {
    hardwareController.shutdown()
  }

  private func normalizedDPI(_ dpi: Int, fallback: Int?) -> Int? {
    dpi > 0 ? dpi : fallback
  }

  private func normalizedPollingRate(_ pollingRate: Int, fallback: Int?) -> Int? {
    pollingRate > 0 ? pollingRate : fallback
  }

  private func updateSelectedDevice(_ update: (inout NativeDevice) -> Void) {
    guard let selectedDeviceId,
          let index = devices.firstIndex(where: { $0.id == selectedDeviceId })
    else {
      return
    }

    update(&devices[index])
  }

  private func statusText(for result: HardwareApplyResult) -> AppMessage {
    switch result {
    case .applied:
      .commandSent
    case .previewOnly(let message):
      message
    case .failed(let message):
      message
    }
  }

  private func summaryText(action: String, result: HardwareApplyResult) -> AppMessage {
    switch result {
    case .applied:
      .sent(action: action)
    case .previewOnly:
      .previewed(action: action)
    case .failed:
      .couldNotApply(action: action)
    }
  }
}
