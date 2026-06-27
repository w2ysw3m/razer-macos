import NativeRazerCore
import SwiftUI

struct DetailView: View {
  let store: NativeDeviceStore

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 18) {
        header
        deviceSummary
        if let device = store.selectedDevice {
          DeviceControlsView(
            device: device,
            onSetDPI: store.setDPI,
            onSetPollingRate: store.setPollingRate
          )
        }
      }
      .padding(24)
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .toolbar {
      ToolbarItem {
        Button {
          store.refresh()
        } label: {
          Label("Refresh", systemImage: "arrow.clockwise")
        }
      }
    }
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text(store.selectedDevice?.name ?? "Razer device")
        .font(.largeTitle.weight(.semibold))

      Text("Adjust device settings and review the current hardware connection.")
        .font(.body)
        .foregroundStyle(.secondary)
    }
  }

  private var deviceSummary: some View {
    GroupBox("Device status") {
      if let device = store.selectedDevice {
        VStack(alignment: .leading, spacing: 12) {
          LabeledContent("Device", value: device.name)
          LabeledContent("Product ID", value: device.productId)
          LabeledContent("Connection", value: device.connection)
          LabeledContent("Status", value: device.bridgeStatus)
          LabeledContent("Last update", value: store.lastRefreshSummary)

          FlowLayout(items: device.capabilities.map(\.rawValue))
        }
      } else {
        ContentUnavailableView("No device selected", systemImage: "questionmark.circle")
      }
    }
  }
}
