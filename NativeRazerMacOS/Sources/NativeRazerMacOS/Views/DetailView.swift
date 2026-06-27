import NativeRazerCore
import SwiftUI

struct DetailView: View {
  let store: NativeDeviceStore
  @Environment(\.appLanguage) private var language

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
          Label(AppText.string(.refresh, language: language), systemImage: "arrow.clockwise")
        }
      }
    }
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text(store.selectedDevice?.name ?? AppText.string(.razerDevice, language: language))
        .font(.largeTitle.weight(.semibold))

      Text(AppText.string(.detailSubtitle, language: language))
        .font(.body)
        .foregroundStyle(.secondary)
    }
  }

  private var deviceSummary: some View {
    GroupBox(AppText.string(.deviceStatus, language: language)) {
      if let device = store.selectedDevice {
        VStack(alignment: .leading, spacing: 12) {
          LabeledContent(AppText.string(.device, language: language), value: device.name)
          LabeledContent(AppText.string(.productID, language: language), value: device.productId)
          LabeledContent(
            AppText.string(.connection, language: language),
            value: device.localizedConnection(language: language)
          )
          LabeledContent(
            AppText.string(.status, language: language),
            value: device.bridgeStatusMessage.localized(language: language)
          )
          LabeledContent(
            AppText.string(.lastUpdate, language: language),
            value: store.lastRefreshSummary.localized(language: language)
          )

          FlowLayout(items: device.capabilities.map { $0.localizedName(language: language) })
        }
      } else {
        ContentUnavailableView(
          AppText.string(.noDeviceSelected, language: language),
          systemImage: "questionmark.circle"
        )
      }
    }
  }
}
