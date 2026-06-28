// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "NativeRazerMacOS",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .library(name: "NativeRazerCore", targets: ["NativeRazerCore"]),
    .executable(name: "NativeRazerMacOS", targets: ["NativeRazerMacOS"])
  ],
  targets: [
    .target(
      name: "NativeRazerBridgeC",
      cSettings: [
        .unsafeFlags(["-I", "../librazermacos/src/include"])
      ],
      linkerSettings: [
        .linkedFramework("CoreFoundation"),
        .linkedFramework("IOKit")
      ]
    ),
    .target(name: "NativeRazerCore"),
    .executableTarget(
      name: "NativeRazerMacOS",
      dependencies: ["NativeRazerBridgeC", "NativeRazerCore"]
    ),
    .testTarget(
      name: "NativeRazerCoreTests",
      dependencies: ["NativeRazerCore"]
    ),
    .testTarget(
      name: "NativeRazerMacOSTests",
      dependencies: ["NativeRazerCore", "NativeRazerMacOS"]
    )
  ]
)
