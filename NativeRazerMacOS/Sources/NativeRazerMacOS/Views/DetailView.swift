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
        migrationStages
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
      Text("Native macOS foundation")
        .font(.largeTitle.weight(.semibold))

      Text("SwiftUI/AppKit controls backed by the librazermacos bridge.")
        .font(.body)
        .foregroundStyle(.secondary)
    }
  }

  private var deviceSummary: some View {
    GroupBox("Current target") {
      if let device = store.selectedDevice {
        VStack(alignment: .leading, spacing: 12) {
          LabeledContent("Device", value: device.name)
          LabeledContent("Product ID", value: device.productId)
          LabeledContent("Connection", value: device.connection)
          LabeledContent("Bridge source", value: store.bridgeSourcePath)
          LabeledContent("Status", value: device.bridgeStatus)

          FlowLayout(items: device.capabilities.map(\.rawValue))
        }
      } else {
        ContentUnavailableView("No device selected", systemImage: "questionmark.circle")
      }
    }
  }

  private var migrationStages: some View {
    GroupBox("Migration stages") {
      VStack(alignment: .leading, spacing: 12) {
        ForEach(store.stages) { stage in
          let isReady = stage != .packaging

          HStack(alignment: .top, spacing: 10) {
            Image(systemName: isReady ? "checkmark.circle" : "circle.dashed")
              .foregroundStyle(isReady ? .green : .secondary)
              .frame(width: 16)

            VStack(alignment: .leading, spacing: 2) {
              HStack {
                Text(stage.rawValue)
                  .font(.headline)

                Text(isReady ? "Ready" : "Next")
                  .font(.caption)
                  .foregroundStyle(.secondary)
              }

              Text(stage.summary)
                .foregroundStyle(.secondary)
            }
          }
        }

        Divider()
        Text(store.lastRefreshSummary)
          .font(.caption)
          .foregroundStyle(.secondary)
      }
    }
  }
}
