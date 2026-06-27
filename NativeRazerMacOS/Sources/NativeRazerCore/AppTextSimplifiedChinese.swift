extension AppText {
  static let simplifiedChinese: [AppStringKey: String] = [
    .aboutCredits: """
    面向 macOS 的 Razer 设备原生 SwiftUI/AppKit 控制应用。

    当前原生界面：
    - 系统状态栏常驻
    - 登录时启动
    - 炼狱蝰蛇 V3 Pro 发现
    - 通过 librazermacos 控制 DPI 和回报率
    - 带保守超时提示的硬件状态

    Legacy Electron 版本保留更广的设备目录和历史灯效/状态逻辑。原生 app 只会在控件已经接入并在 macOS 硬件上测试后，才把设备标为原生就绪。

    基于 1kc/razer-macos、librazermacos 和 OpenRazer 设备资料构建。
    """,
    .aboutRazerMacOS: "关于 Razer macOS",
    .appBuildDescription: "SwiftUI/AppKit + librazermacos 桥接",
    .appTitle: "Razer macOS 原生版",
    .battery: "电量",
    .batteryMenu: "电量：%d%%",
    .batteryStatusUnavailable: "当前桥接读取不到电量状态。",
    .bridgeCommandSent: "命令已通过 librazermacos 桥接发送。",
    .bridgeConnected: "已通过 librazermacos 桥接连接。",
    .bridgeDetectedReadTimedOut: "已通过 librazermacos 检测到设备；读取设置超时。",
    .bridgeReadyForBridge: "已准备好使用 librazermacos 桥接。",
    .capabilityBattery: "电量",
    .capabilityDPI: "DPI",
    .capabilityDiscovery: "USB 发现",
    .capabilityLighting: "灯效",
    .capabilityPollingRate: "回报率",
    .capabilityProfiles: "配置文件",
    .charging: "正在充电",
    .connection: "连接",
    .connectionLibrazermacosInternal: "librazermacos 内部编号 #%@",
    .connectionUSBReceiverWired: "USB 接收器 / 有线",
    .controlsPreviewHardwareNotMatched: "控件可预览；未匹配到硬件。",
    .couldNotApplyAction: "无法应用 %@",
    .device: "设备",
    .deviceBridge: "设备桥接",
    .deviceControls: "设备控制",
    .deviceStatus: "设备状态",
    .devices: "设备",
    .detailSubtitle: "调整设备设置，并查看当前硬件连接状态。",
    .dpiMenu: "DPI：%d",
    .general: "通用",
    .hardwareNoConnectedMouse: "没有匹配到已连接的 librazermacos 鼠标。",
    .hardwareRejectedDPI: "librazermacos 拒绝了 DPI 更新。",
    .hardwareRejectedPollingRate: "librazermacos 拒绝了回报率更新。",
    .language: "语言",
    .lastUpdate: "上次更新",
    .launchAtLogin: "登录时启动",
    .launchAtLoginDisabledMessage: "登录时启动已关闭。",
    .launchAtLoginEnabledMessage: "登录时启动已开启。",
    .launchAtLoginHelp: "登录时启动通过 macOS ServiceManagement 注册。如果本地未签名构建显示需要批准或不可用，请检查系统设置 > 通用 > 登录项。",
    .launchAtLoginStatus: "登录时启动状态",
    .lighting: "灯效",
    .lightingUnavailable: "此设备配置未暴露灯效控制。",
    .liveMouseLoaded: "已加载实时 Razer 鼠标：%d",
    .noDeviceSelected: "未选择设备",
    .noRazerMouse: "没有 Razer 鼠标",
    .openLoginItemsSettings: "打开系统设置中的登录项",
    .openRazerMacOS: "打开 Razer macOS",
    .pollingRate: "回报率",
    .previewedAction: "已预览 %@；未匹配到硬件",
    .productID: "产品 ID",
    .quit: "退出",
    .rateMenu: "回报率：%d Hz",
    .razerDevice: "Razer 设备",
    .readyToBridge: "已准备桥接 %@",
    .refresh: "刷新",
    .refreshDevices: "刷新设备",
    .runtime: "运行时",
    .savePollingRate: "保存回报率",
    .sentAction: "已发送 %@ 到硬件",
    .setDPI: "设置 DPI",
    .settings: "设置",
    .signing: "签名",
    .signingPlanned: "计划中",
    .status: "状态",
    .statusBar: "系统状态栏",
    .statusBarAlwaysOn: "始终开启",
    .statusDisabled: "已关闭",
    .statusEnabled: "已开启",
    .statusRequiresApproval: "需要批准",
    .statusUnavailable: "不可用",
    .statusUnknown: "未知",
    .targetLoadedNoLiveMouse: "已加载目标设备：%d；未匹配到实时 Razer 鼠标"
  ]
}
