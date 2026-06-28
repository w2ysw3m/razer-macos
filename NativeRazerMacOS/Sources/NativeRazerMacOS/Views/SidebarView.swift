import NativeRazerCore
import SwiftUI

struct SidebarView: View {
  let devices: [NativeDevice]
  @Binding var selection: NativeDevice.ID?
  @Binding var searchText: String
  @Environment(\.appLanguage) private var language

  private var filteredDevices: [NativeDevice] {
    let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !query.isEmpty else {
      return devices
    }

    return devices.filter { device in
      device.name.localizedCaseInsensitiveContains(query)
        || device.productId.localizedCaseInsensitiveContains(query)
        || device.kind.rawValue.localizedCaseInsensitiveContains(query)
    }
  }

  var body: some View {
    List(selection: $selection) {
      Section(AppText.string(.devices, language: language)) {
        ForEach(filteredDevices) { device in
          HStack(spacing: 10) {
            Image(systemName: iconName(for: device.kind))
              .foregroundStyle(.secondary)
              .frame(width: 16)

            VStack(alignment: .leading, spacing: 2) {
              Text(device.name)
                .lineLimit(1)

              Text(device.productId)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
            }
          }
          .tag(device.id)
        }
      }
    }
    .listStyle(.sidebar)
    .searchable(
      text: $searchText,
      placement: .sidebar,
      prompt: AppText.string(.searchDevices, language: language)
    )
  }

  private func iconName(for kind: NativeDeviceKind) -> String {
    switch kind {
    case .keyboard:
      "keyboard"
    case .mouse, .mouseDock:
      "computermouse"
    case .mouseMat:
      "rectangle.grid.2x2"
    case .headphone:
      "headphones"
    case .egpu:
      "externaldrive"
    case .accessory:
      "sparkles"
    case .unknown:
      "questionmark.square"
    }
  }
}
