import NativeRazerCore
import SwiftUI

struct SidebarView: View {
  let devices: [NativeDevice]
  @Binding var selection: NativeDevice.ID?

  var body: some View {
    List(selection: $selection) {
      Section("Devices") {
        ForEach(devices) { device in
          HStack(spacing: 10) {
            Image(systemName: "computermouse")
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
  }
}
