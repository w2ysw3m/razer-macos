public enum DeviceCapability: String, CaseIterable, Identifiable, Sendable {
  case discovery = "USB discovery"
  case lighting = "Lighting effects"
  case dpi = "DPI"
  case pollingRate = "Polling rate"
  case battery = "Battery"
  case profiles = "Profiles"

  public var id: String { rawValue }
}
