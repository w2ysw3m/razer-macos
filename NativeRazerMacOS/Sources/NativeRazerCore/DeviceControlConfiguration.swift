public struct DeviceControlConfiguration: Equatable, Sendable {
  public let dpi: DPIConfiguration?
  public let pollingRates: [Int]
  public let brightnessZones: [BrightnessZone]
  public let supportsStaticColor: Bool

  public init(
    dpi: DPIConfiguration?,
    pollingRates: [Int],
    brightnessZones: [BrightnessZone] = [],
    supportsStaticColor: Bool = false
  ) {
    self.dpi = dpi
    self.pollingRates = pollingRates
    self.brightnessZones = brightnessZones
    self.supportsStaticColor = supportsStaticColor
  }

  public var supportsPollingRate: Bool {
    !pollingRates.isEmpty
  }

  public static let deathAdderV3Pro = DeviceControlConfiguration(
    dpi: DPIConfiguration(min: 100, max: 35_000, step: 100),
    pollingRates: [125, 250, 500, 1_000]
  )

  public static let none = DeviceControlConfiguration(
    dpi: nil,
    pollingRates: []
  )
}

public struct DPIConfiguration: Equatable, Sendable {
  public let min: Int
  public let max: Int
  public let step: Int

  public init(min: Int, max: Int, step: Int) {
    self.min = min
    self.max = max
    self.step = step
  }
}

public enum BrightnessZone: String, CaseIterable, Identifiable, Sendable {
  case all = "All"
  case logo = "Logo"
  case scroll = "Scroll wheel"
  case left = "Left side"
  case right = "Right side"

  public var id: String { rawValue }
}
