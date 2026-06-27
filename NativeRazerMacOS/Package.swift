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
    .target(name: "NativeRazerCore"),
    .executableTarget(
      name: "NativeRazerMacOS",
      dependencies: ["NativeRazerCore"]
    ),
    .testTarget(
      name: "NativeRazerCoreTests",
      dependencies: ["NativeRazerCore"]
    )
  ]
)
