import Testing
@testable import NativeRazerCore

struct MigrationInventoryTests {
  @Test func primaryDevice_whenDeathAdderV3ProExists() {
    let inventory = MigrationInventory()

    #expect(inventory.primaryDevice?.name == "Razer DeathAdder V3 Pro")
    #expect(inventory.primaryDevice?.productId == "0x00B7")
  }

  @Test func supportedCapabilityCount_whenDefaultInventoryLoaded() {
    let inventory = MigrationInventory()

    #expect(inventory.supportedCapabilityCount == 4)
  }
}
