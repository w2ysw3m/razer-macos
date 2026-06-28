import Foundation

enum HardwareProbe {
  static func runAndExit() -> Never {
    let controller = NativeRazerHardwareController()
    let devices = controller.refreshDevices()
    let snapshots = controller.refreshMice()

    for device in devices {
      print(
        [
          "device",
          "productId=\(device.productId)",
          "internalDeviceId=\(device.internalDeviceId)",
          "kind=\(device.kind.rawValue)"
        ].joined(separator: " ")
      )
    }

    for snapshot in snapshots {
      var fields = [
        "mouse",
        "productId=\(snapshot.productId)",
        "internalDeviceId=\(snapshot.internalDeviceId)",
        "dpi=\(snapshot.dpi)",
        "pollingRate=\(snapshot.pollingRate)"
      ]

      if let batteryLevel = snapshot.batteryLevel {
        fields.append("battery=\(batteryLevel)")
      }

      print(fields.joined(separator: " "))
    }

    print("count=\(devices.count)")
    controller.shutdown()
    exit(0)
  }
}
