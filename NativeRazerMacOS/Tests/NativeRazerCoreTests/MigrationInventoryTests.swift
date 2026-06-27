import Testing
@testable import NativeRazerCore

struct MigrationInventoryTests {
  @Test func primaryDevice_whenMultipleDevicesContainDeathAdderV3Pro() {
    let inventory = MigrationInventory(devices: [
      NativeDevice(
        id: "viper",
        name: "Razer Viper V3 Pro",
        productId: "0x00C1",
        connection: "USB receiver",
        capabilities: [.discovery, .dpi],
        bridgeStatus: "Queued"
      ),
      NativeDevice(
        id: "deathadder-v3-pro",
        name: "Razer DeathAdder V3 Pro",
        productId: "0x00B7",
        connection: "USB receiver / wired",
        capabilities: [.discovery, .dpi, .pollingRate, .battery],
        bridgeStatus: "Ready"
      )
    ])

    #expect(inventory.primaryDevice?.name == "Razer DeathAdder V3 Pro")
    #expect(inventory.primaryDevice?.productId == "0x00B7")
  }

  @Test func primaryDevice_whenDeathAdderV3ProIsAbsent() {
    let inventory = MigrationInventory(devices: [
      NativeDevice(
        id: "naga",
        name: "Razer Naga",
        productId: "0x0040",
        connection: "Wired",
        capabilities: [.discovery, .lighting],
        bridgeStatus: "Queued"
      )
    ])

    #expect(inventory.primaryDevice == nil)
  }

  @Test func supportedCapabilityCount_whenDevicesShareCapabilities() {
    let inventory = MigrationInventory(devices: [
      NativeDevice(
        id: "mouse",
        name: "Mouse",
        productId: "0x1000",
        connection: "Wired",
        capabilities: [.discovery, .dpi, .battery],
        bridgeStatus: "Ready"
      ),
      NativeDevice(
        id: "receiver",
        name: "Receiver",
        productId: "0x1001",
        connection: "USB receiver",
        capabilities: [.discovery, .dpi, .pollingRate],
        bridgeStatus: "Queued"
      )
    ])

    #expect(inventory.supportedCapabilityCount == 4)
  }

  @Test func deathAdderV3ProControlConfiguration_matchesMigratedMouseFeatures() throws {
    let inventory = MigrationInventory()
    let device = try #require(inventory.primaryDevice)

    #expect(device.controlConfiguration.dpi?.min == 100)
    #expect(device.controlConfiguration.dpi?.max == 35_000)
    #expect(device.controlConfiguration.dpi?.step == 100)
    #expect(device.controlConfiguration.pollingRates == [125, 250, 500, 1_000])
    #expect(device.controlState.dpi == 1_600)
    #expect(device.controlState.pollingRate == 1_000)
  }
}
