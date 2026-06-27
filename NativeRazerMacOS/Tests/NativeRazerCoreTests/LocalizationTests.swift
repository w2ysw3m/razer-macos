import Testing
@testable import NativeRazerCore

struct LocalizationTests {
  @Test func appText_whenCheckingSupportedLanguages_hasNoMissingTranslations() {
    let missingTranslations = AppText.missingTranslations()

    #expect(missingTranslations.isEmpty, "\(missingTranslations)")
  }

  @Test func appMessage_whenFormattingDynamicValues_preservesDeviceDetails() {
    let message = AppMessage.readyToBridge(path: "../librazermacos/src")

    #expect(message.localized(language: .english).contains("../librazermacos/src"))
    #expect(message.localized(language: .simplifiedChinese).contains("../librazermacos/src"))
    #expect(message.localized(language: .traditionalChinese).contains("../librazermacos/src"))
  }

  @Test func deviceCapability_whenLocalized_usesSelectedLanguage() {
    #expect(DeviceCapability.pollingRate.localizedName(language: .english) == "Polling rate")
    #expect(DeviceCapability.pollingRate.localizedName(language: .simplifiedChinese) == "回报率")
    #expect(DeviceCapability.pollingRate.localizedName(language: .traditionalChinese) == "回報率")
  }

  @Test func nativeDeviceConnection_whenKnownValueIsLocalized_usesSelectedLanguage() {
    let device = NativeDevice(
      id: "deathadder-v3-pro",
      name: "Razer DeathAdder V3 Pro",
      productId: "0x00B7",
      connection: "USB receiver / wired",
      capabilities: [.discovery],
      bridgeStatus: "Ready"
    )

    #expect(device.localizedConnection(language: .english) == "USB receiver / wired")
    #expect(device.localizedConnection(language: .simplifiedChinese) == "USB 接收器 / 有线")
    #expect(device.localizedConnection(language: .traditionalChinese) == "USB 接收器 / 有線")
  }
}
