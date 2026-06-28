public struct DeviceControlState: Equatable, Sendable {
  public var dpi: Int?
  public var pollingRate: Int?
  public var batteryLevel: Int?
  public var isCharging: Bool?
  public var brightness: [BrightnessZone: Int]
  public var staticColor: RazerColor
  public var activeMode: LightingMode

  public init(
    dpi: Int? = nil,
    pollingRate: Int? = nil,
    batteryLevel: Int? = nil,
    isCharging: Bool? = nil,
    brightness: [BrightnessZone: Int] = [:],
    staticColor: RazerColor = RazerColor(red: 0, green: 255, blue: 0),
    activeMode: LightingMode = .none
  ) {
    self.dpi = dpi
    self.pollingRate = pollingRate
    self.batteryLevel = batteryLevel
    self.isCharging = isCharging
    self.brightness = brightness
    self.staticColor = staticColor
    self.activeMode = activeMode
  }

  public static let deathAdderV3ProDefault = DeviceControlState(
    dpi: 1_600,
    pollingRate: 1_000
  )
}

public struct RazerColor: Equatable, Sendable {
  public var red: Int
  public var green: Int
  public var blue: Int

  public init(red: Int, green: Int, blue: Int) {
    self.red = red
    self.green = green
    self.blue = blue
  }
}

public enum LightingMode: String, CaseIterable, Identifiable, Sendable {
  case none = "None"
  case staticColor = "Static"
  case spectrum = "Spectrum"
  case breathe = "Breathe"
  case reactive = "Reactive"
  case starlight = "Starlight"
  case wave = "Wave"
  case ripple = "Ripple"
  case wheel = "Wheel"
  case oldMouseEffects = "Old mouse effects"

  public var id: String { rawValue }
}
