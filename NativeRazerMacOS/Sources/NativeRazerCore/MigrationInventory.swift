public struct MigrationInventory: Sendable {
  public let devices: [NativeDevice]
  public let stages: [MigrationStage]
  public let bridgeSourcePath: String

  public init(
    devices: [NativeDevice] = MigrationInventory.defaultDevices,
    stages: [MigrationStage] = MigrationStage.allCases,
    bridgeSourcePath: String = "../librazermacos/src"
  ) {
    self.devices = devices
    self.stages = stages
    self.bridgeSourcePath = bridgeSourcePath
  }

  public var primaryDevice: NativeDevice? {
    devices.first { device in
      device.productId == "0x00B7"
    }
  }

  public var supportedCapabilityCount: Int {
    Set(devices.flatMap(\.capabilities)).count
  }

  public static let defaultDevices = [
    NativeDevice(
      id: "deathadder-v3-pro",
      name: "Razer DeathAdder V3 Pro",
      productId: "0x00B7",
      connection: "USB receiver / wired",
      capabilities: [.discovery, .dpi, .pollingRate, .battery],
      bridgeStatus: "Ready for librazermacos bridge.",
      bridgeStatusMessage: .readyForBridge,
      controlConfiguration: .deathAdderV3Pro,
      controlState: .deathAdderV3ProDefault
    )
  ]
}
