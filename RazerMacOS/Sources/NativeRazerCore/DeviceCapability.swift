public enum DeviceCapability: String, CaseIterable, Identifiable, Sendable {
  case discovery = "USB discovery"
  case lighting = "Lighting effects"
  case dpi = "DPI"
  case pollingRate = "Polling rate"
  case battery = "Battery"
  case profiles = "Profiles"

  public var id: String { rawValue }

  public func localizedName(language: AppLanguage) -> String {
    switch self {
    case .discovery:
      AppText.string(.capabilityDiscovery, language: language)
    case .lighting:
      AppText.string(.capabilityLighting, language: language)
    case .dpi:
      AppText.string(.capabilityDPI, language: language)
    case .pollingRate:
      AppText.string(.capabilityPollingRate, language: language)
    case .battery:
      AppText.string(.capabilityBattery, language: language)
    case .profiles:
      AppText.string(.capabilityProfiles, language: language)
    }
  }
}
