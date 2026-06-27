import Foundation
import NativeRazerBridgeC

struct HardwareMouseSnapshot: Equatable {
  let internalDeviceId: Int
  let productId: String
  let dpi: Int
  let pollingRate: Int
  let batteryLevel: Int?
  let isCharging: Bool?
}

enum HardwareApplyResult: Equatable {
  case applied
  case previewOnly(String)
  case failed(String)
}

protocol NativeRazerHardwareControlling {
  func refreshMice() -> [HardwareMouseSnapshot]
  func setDPI(_ dpi: Int, internalDeviceId: Int?) -> HardwareApplyResult
  func setPollingRate(_ pollingRate: Int, internalDeviceId: Int?) -> HardwareApplyResult
  func shutdown()
}

final class NativeRazerHardwareController: NativeRazerHardwareControlling {
  func refreshMice() -> [HardwareMouseSnapshot] {
    var snapshots = Array(
      repeating: NativeRazerMouseSnapshot(),
      count: 16
    )
    let count = NativeRazerRefreshMice(&snapshots, Int32(snapshots.count))

    guard count > 0 else {
      return []
    }

    return snapshots.prefix(Int(count)).map { snapshot in
      HardwareMouseSnapshot(
        internalDeviceId: Int(snapshot.internalDeviceId),
        productId: productIdString(snapshot.productId),
        dpi: Int(snapshot.dpi),
        pollingRate: Int(snapshot.pollingRate),
        batteryLevel: snapshot.batteryLevel >= 0 ? Int(snapshot.batteryLevel) : nil,
        isCharging: snapshot.batteryLevel >= 0 ? snapshot.charging == 1 : nil
      )
    }
  }

  func setDPI(_ dpi: Int, internalDeviceId: Int?) -> HardwareApplyResult {
    guard let internalDeviceId else {
      return .previewOnly("No connected librazermacos mouse matched this device.")
    }

    let result = NativeRazerSetMouseDPI(Int32(internalDeviceId), UInt16(clamping: dpi))
    return result == 0 ? .applied : .failed("librazermacos rejected DPI update.")
  }

  func setPollingRate(_ pollingRate: Int, internalDeviceId: Int?) -> HardwareApplyResult {
    guard let internalDeviceId else {
      return .previewOnly("No connected librazermacos mouse matched this device.")
    }

    let result = NativeRazerSetMousePollingRate(Int32(internalDeviceId), UInt16(clamping: pollingRate))
    return result == 0 ? .applied : .failed("librazermacos rejected polling-rate update.")
  }

  func shutdown() {
    NativeRazerShutdown()
  }

  private func productIdString(_ productId: UInt16) -> String {
    "0x" + String(format: "%04X", productId)
  }
}
