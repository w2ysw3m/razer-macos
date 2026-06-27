extension AppText {
  static let english: [AppStringKey: String] = [
    .aboutCredits: """
    Native SwiftUI/AppKit control app for Razer devices on macOS.

    Current native surface:
    - Menu-bar resident app
    - Launch at Login
    - DeathAdder V3 Pro discovery
    - DPI and polling-rate controls through librazermacos
    - Hardware status with conservative timeout reporting

    Legacy Electron support keeps the broader device catalog and historical color/state logic. The native app marks a device native-ready only after its controls are wired and tested on macOS hardware.

    Built on 1kc/razer-macos, librazermacos, and OpenRazer device work.
    """,
    .aboutRazerMacOS: "About Razer macOS",
    .appBuildDescription: "SwiftUI/AppKit + librazermacos bridge",
    .appTitle: "Razer macOS Native",
    .battery: "Battery",
    .batteryMenu: "Battery: %d%%",
    .batteryStatusUnavailable: "Battery status unavailable from the current bridge read.",
    .bridgeCommandSent: "Command sent through librazermacos bridge.",
    .bridgeConnected: "Connected through librazermacos bridge.",
    .bridgeDetectedReadTimedOut: "Detected through librazermacos; settings read timed out.",
    .bridgeReadyForBridge: "Ready for librazermacos bridge.",
    .capabilityBattery: "Battery",
    .capabilityDPI: "DPI",
    .capabilityDiscovery: "USB discovery",
    .capabilityLighting: "Lighting effects",
    .capabilityPollingRate: "Polling rate",
    .capabilityProfiles: "Profiles",
    .charging: "Charging",
    .connection: "Connection",
    .connectionLibrazermacosInternal: "librazermacos internal #%@",
    .connectionUSBReceiverWired: "USB receiver / wired",
    .controlsPreviewHardwareNotMatched: "Controls available in preview; hardware not matched.",
    .couldNotApplyAction: "Could not apply %@",
    .device: "Device",
    .deviceBridge: "Device bridge",
    .deviceControls: "Device controls",
    .deviceStatus: "Device status",
    .devices: "Devices",
    .detailSubtitle: "Adjust device settings and review the current hardware connection.",
    .dpiMenu: "DPI: %d",
    .general: "General",
    .hardwareNoConnectedMouse: "No connected librazermacos mouse matched this device.",
    .hardwareRejectedDPI: "librazermacos rejected DPI update.",
    .hardwareRejectedPollingRate: "librazermacos rejected polling-rate update.",
    .language: "Language",
    .lastUpdate: "Last update",
    .launchAtLogin: "Launch at Login",
    .launchAtLoginDisabledMessage: "Launch at Login is disabled.",
    .launchAtLoginEnabledMessage: "Launch at Login is enabled.",
    .launchAtLoginHelp: "Launch at Login is registered with macOS ServiceManagement. If the local unsigned build shows Requires approval or Unavailable, check System Settings > General > Login Items.",
    .launchAtLoginStatus: "Launch at Login status",
    .lighting: "Lighting",
    .lightingUnavailable: "This device profile does not expose lighting controls.",
    .liveMouseLoaded: "Live Razer mice loaded: %d",
    .noDeviceSelected: "No device selected",
    .noRazerMouse: "No Razer mouse",
    .openLoginItemsSettings: "Open Login Items in System Settings",
    .openRazerMacOS: "Open Razer macOS",
    .pollingRate: "Polling rate",
    .previewedAction: "Previewed %@; hardware not matched",
    .productID: "Product ID",
    .quit: "Quit",
    .rateMenu: "Rate: %d Hz",
    .razerDevice: "Razer device",
    .readyToBridge: "Ready to bridge %@",
    .refresh: "Refresh",
    .refreshDevices: "Refresh Devices",
    .runtime: "Runtime",
    .savePollingRate: "Save Polling Rate",
    .sentAction: "Sent %@ to hardware",
    .setDPI: "Set DPI",
    .settings: "Settings",
    .signing: "Signing",
    .signingPlanned: "Planned",
    .status: "Status",
    .statusBar: "Status bar",
    .statusBarAlwaysOn: "Always on",
    .statusDisabled: "Disabled",
    .statusEnabled: "Enabled",
    .statusRequiresApproval: "Requires approval",
    .statusUnavailable: "Unavailable",
    .statusUnknown: "Unknown",
    .targetLoadedNoLiveMouse: "Target devices loaded: %d; no live Razer mouse matched"
  ]
}
