import Testing
@testable import NativeRazerCore
@testable import NativeRazerMacOS

struct NativeDeviceStoreHardwareTests {
  @Test func refresh_whenKeyboardHardwareMatchesLegacyCatalog_marksDeviceConnected() throws {
    let hardware = FakeHardwareController(
      devices: [
        HardwareDeviceSnapshot(
          internalDeviceId: 77,
          productId: "0x0204",
          kind: .keyboard
        )
      ]
    )

    let store = NativeDeviceStore(hardwareController: hardware)
    let device = try #require(store.devices.first { device in
      device.productId == "0x0204"
    })

    #expect(device.name == "Razer Deathstalker Chroma")
    #expect(device.hardwareInternalId == 77)
    #expect(device.bridgeStatusMessage == .connected)
    #expect(device.controlConfiguration.supportsLighting)
  }

  @Test func hardwareController_whenSettingLightingOrBrightness_returnsPreviewOnly() {
    let controller = NativeRazerHardwareController()

    #expect(
      controller.setLightingMode(
        .staticColor,
        color: RazerColor(red: 0, green: 255, blue: 0),
        kind: .keyboard,
        internalDeviceId: 77
      ) == .previewOnly(.lightingPreviewOnly)
    )
    #expect(
      controller.setBrightness(
        80,
        zone: .all,
        kind: .keyboard,
        internalDeviceId: 77
      ) == .previewOnly(.lightingPreviewOnly)
    )
  }

  @Test func store_whenLightingPreviewIsApplied_updatesPreviewStateWithoutHardwareSuccess() throws {
    let hardware = FakeHardwareController(
      devices: [
        HardwareDeviceSnapshot(
          internalDeviceId: 77,
          productId: "0x0204",
          kind: .keyboard
        )
      ],
      lightingResult: .previewOnly(.lightingPreviewOnly)
    )
    let store = NativeDeviceStore(hardwareController: hardware)
    let device = try #require(store.devices.first { device in
      device.productId == "0x0204"
    })
    store.selectedDeviceId = device.id

    store.setLightingMode(.wave)

    let updatedDevice = try #require(store.selectedDevice)
    #expect(hardware.lightingCalls == 1)
    #expect(updatedDevice.controlState.activeMode == .wave)
    #expect(updatedDevice.bridgeStatusMessage == .lightingPreviewOnly)
    #expect(store.lastRefreshSummary == .previewed(action: "Wave"))
  }
}

private final class FakeHardwareController: NativeRazerHardwareControlling {
  let devices: [HardwareDeviceSnapshot]
  let mice: [HardwareMouseSnapshot]
  let lightingResult: HardwareApplyResult
  var lightingCalls = 0

  init(
    devices: [HardwareDeviceSnapshot] = [],
    mice: [HardwareMouseSnapshot] = [],
    lightingResult: HardwareApplyResult = .previewOnly(.lightingPreviewOnly)
  ) {
    self.devices = devices
    self.mice = mice
    self.lightingResult = lightingResult
  }

  func refreshDevices() -> [HardwareDeviceSnapshot] {
    devices
  }

  func refreshMice() -> [HardwareMouseSnapshot] {
    mice
  }

  func setDPI(_ dpi: Int, internalDeviceId: Int?) -> HardwareApplyResult {
    .previewOnly(.hardwareNoConnectedMouse)
  }

  func setPollingRate(_ pollingRate: Int, internalDeviceId: Int?) -> HardwareApplyResult {
    .previewOnly(.hardwareNoConnectedMouse)
  }

  func setLightingMode(
    _ mode: LightingMode,
    color: RazerColor,
    kind: NativeDeviceKind,
    internalDeviceId: Int?
  ) -> HardwareApplyResult {
    lightingCalls += 1
    return lightingResult
  }

  func setBrightness(
    _ brightness: Int,
    zone: BrightnessZone,
    kind: NativeDeviceKind,
    internalDeviceId: Int?
  ) -> HardwareApplyResult {
    .previewOnly(.lightingPreviewOnly)
  }

  func shutdown() {}
}
