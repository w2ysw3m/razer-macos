import Foundation

enum HardwareProbe {
  static func runAndExit() -> Never {
    let controller = NativeRazerHardwareController()
    let snapshots = controller.refreshMice()

    for snapshot in snapshots {
      var fields = [
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

    print("count=\(snapshots.count)")
    controller.shutdown()
    exit(0)
  }
}
