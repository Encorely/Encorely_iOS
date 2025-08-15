import SwiftUI

struct AlarmRow: View {
    let item: AlarmItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 36, height: 36)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.content)
                    .font(.body)
                Text(item.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}
