extension AppText {
  static let traditionalChinese: [AppStringKey: String] = [
    .aboutCredits: """
    面向 macOS 的 Razer 裝置原生 SwiftUI/AppKit 控制 App。

    目前原生介面：
    - 系統狀態列常駐
    - 登入時啟動
    - 煉獄蝰蛇 V3 Pro 偵測
    - 透過 librazermacos 控制 DPI 及回報率
    - 具保守逾時提示的硬件狀態

    Legacy Electron 版本保留更廣的裝置清單及歷史燈效/狀態邏輯。原生 app 只會在控制項已接入並於 macOS 硬件上測試後，才將裝置標為原生就緒。

    基於 1kc/razer-macos、librazermacos 及 OpenRazer 裝置資料構建。
    """,
    .aboutRazerMacOS: "關於 Razer macOS",
    .appBuildDescription: "SwiftUI/AppKit + librazermacos 橋接",
    .appTitle: "Razer macOS 原生版",
    .battery: "電量",
    .batteryMenu: "電量：%d%%",
    .batteryStatusUnavailable: "目前橋接讀取不到電量狀態。",
    .bridgeCommandSent: "指令已透過 librazermacos 橋接送出。",
    .bridgeConnected: "已透過 librazermacos 橋接連接。",
    .bridgeDetectedReadTimedOut: "已透過 librazermacos 偵測到裝置；讀取設定逾時。",
    .bridgeReadyForBridge: "已準備好使用 librazermacos 橋接。",
    .capabilityBattery: "電量",
    .capabilityDPI: "DPI",
    .capabilityDiscovery: "USB 偵測",
    .capabilityLighting: "燈效",
    .capabilityPollingRate: "回報率",
    .capabilityProfiles: "設定檔",
    .charging: "正在充電",
    .connection: "連接",
    .connectionLibrazermacosInternal: "librazermacos 內部編號 #%@",
    .connectionUSBReceiverWired: "USB 接收器 / 有線",
    .controlsPreviewHardwareNotMatched: "控制項可預覽；未匹配到硬件。",
    .couldNotApplyAction: "無法套用 %@",
    .device: "裝置",
    .deviceBridge: "裝置橋接",
    .deviceControls: "裝置控制",
    .deviceStatus: "裝置狀態",
    .devices: "裝置",
    .detailSubtitle: "調整裝置設定，並查看目前硬件連接狀態。",
    .dpiMenu: "DPI：%d",
    .general: "一般",
    .hardwareNoConnectedMouse: "沒有匹配到已連接的 librazermacos 滑鼠。",
    .hardwareRejectedDPI: "librazermacos 拒絕了 DPI 更新。",
    .hardwareRejectedPollingRate: "librazermacos 拒絕了回報率更新。",
    .language: "語言",
    .lastUpdate: "上次更新",
    .launchAtLogin: "登入時啟動",
    .launchAtLoginDisabledMessage: "登入時啟動已關閉。",
    .launchAtLoginEnabledMessage: "登入時啟動已開啟。",
    .launchAtLoginHelp: "登入時啟動透過 macOS ServiceManagement 註冊。如果本機未簽名構建顯示需要批准或不可用，請檢查系統設定 > 一般 > 登入項目。",
    .launchAtLoginStatus: "登入時啟動狀態",
    .lighting: "燈效",
    .lightingUnavailable: "此裝置設定未開放燈效控制。",
    .liveMouseLoaded: "已載入即時 Razer 滑鼠：%d",
    .noDeviceSelected: "未選擇裝置",
    .noRazerMouse: "沒有 Razer 滑鼠",
    .openLoginItemsSettings: "開啟系統設定中的登入項目",
    .openRazerMacOS: "開啟 Razer macOS",
    .pollingRate: "回報率",
    .previewedAction: "已預覽 %@；未匹配到硬件",
    .productID: "產品 ID",
    .quit: "結束",
    .rateMenu: "回報率：%d Hz",
    .razerDevice: "Razer 裝置",
    .readyToBridge: "已準備橋接 %@",
    .refresh: "重新整理",
    .refreshDevices: "重新整理裝置",
    .runtime: "執行環境",
    .savePollingRate: "儲存回報率",
    .sentAction: "已傳送 %@ 到硬件",
    .setDPI: "設定 DPI",
    .settings: "設定",
    .signing: "簽名",
    .signingPlanned: "計劃中",
    .status: "狀態",
    .statusBar: "系統狀態列",
    .statusBarAlwaysOn: "始終開啟",
    .statusDisabled: "已關閉",
    .statusEnabled: "已開啟",
    .statusRequiresApproval: "需要批准",
    .statusUnavailable: "不可用",
    .statusUnknown: "未知",
    .targetLoadedNoLiveMouse: "已載入目標裝置：%d；未匹配到即時 Razer 滑鼠"
  ]
}
