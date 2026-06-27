import Foundation
import NativeRazerCore
import Observation

@Observable
final class NativeDeviceStore {
  private let inventory: MigrationInventory
  private(set) var devices: [NativeDevice]
  private(set) var stages: [MigrationStage]
  var selectedDeviceId: NativeDevice.ID?
  var lastRefreshSummary: String

  init(inventory: MigrationInventory = MigrationInventory()) {
    self.inventory = inventory
    self.devices = inventory.devices
    self.stages = inventory.stages
    self.selectedDeviceId = inventory.primaryDevice?.id ?? inventory.devices.first?.id
    self.lastRefreshSummary = "Ready to bridge \(inventory.bridgeSourcePath)"
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
    devices = inventory.devices
    stages = inventory.stages
    selectedDeviceId = selectedDevice?.id ?? inventory.primaryDevice?.id
    lastRefreshSummary = "Loaded \(devices.count) native migration target"
  }
}
