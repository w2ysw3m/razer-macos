import SwiftUI

struct FlowLayout: View {
  let items: [String]

  var body: some View {
    HStack(spacing: 8) {
      ForEach(items, id: \.self) { item in
        Text(item)
          .font(.caption)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(.quaternary, in: Capsule())
      }
    }
  }
}
