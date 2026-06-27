public enum AppMessage: Equatable, Sendable {
  case commandSent
  case connected
  case controlsPreviewHardwareNotMatched
  case couldNotApply(action: String)
  case detectedReadTimedOut
  case hardwareNoConnectedMouse
  case hardwareRejectedDPI
  case hardwareRejectedPollingRate
  case launchAtLoginDisabled
  case launchAtLoginEnabled
  case liveMouseLoaded(count: Int)
  case passthrough(String)
  case previewed(action: String)
  case readyForBridge
  case readyToBridge(path: String)
  case sent(action: String)
  case targetLoadedNoLiveMouse(count: Int)

  public func localized(language: AppLanguage) -> String {
    switch self {
    case .commandSent:
      AppText.string(.bridgeCommandSent, language: language)
    case .connected:
      AppText.string(.bridgeConnected, language: language)
    case .controlsPreviewHardwareNotMatched:
      AppText.string(.controlsPreviewHardwareNotMatched, language: language)
    case .couldNotApply(let action):
      AppText.formatted(.couldNotApplyAction, language: language, action)
    case .detectedReadTimedOut:
      AppText.string(.bridgeDetectedReadTimedOut, language: language)
    case .hardwareNoConnectedMouse:
      AppText.string(.hardwareNoConnectedMouse, language: language)
    case .hardwareRejectedDPI:
      AppText.string(.hardwareRejectedDPI, language: language)
    case .hardwareRejectedPollingRate:
      AppText.string(.hardwareRejectedPollingRate, language: language)
    case .launchAtLoginDisabled:
      AppText.string(.launchAtLoginDisabledMessage, language: language)
    case .launchAtLoginEnabled:
      AppText.string(.launchAtLoginEnabledMessage, language: language)
    case .liveMouseLoaded(let count):
      AppText.formatted(.liveMouseLoaded, language: language, count)
    case .passthrough(let message):
      message
    case .previewed(let action):
      AppText.formatted(.previewedAction, language: language, action)
    case .readyForBridge:
      AppText.string(.bridgeReadyForBridge, language: language)
    case .readyToBridge(let path):
      AppText.formatted(.readyToBridge, language: language, path)
    case .sent(let action):
      AppText.formatted(.sentAction, language: language, action)
    case .targetLoadedNoLiveMouse(let count):
      AppText.formatted(.targetLoadedNoLiveMouse, language: language, count)
    }
  }
}
