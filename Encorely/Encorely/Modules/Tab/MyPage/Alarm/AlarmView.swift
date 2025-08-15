import SwiftUI

struct AlarmView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AlarmViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 상단 바
            HStack {
                Button { dismiss() } label: {
                    Image("chevronLeft")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Spacer()
                Text("알림")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Color.clear.frame(width: 30, height: 30)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)

            Divider()

            // MARK: - 알림 리스트
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !viewModel.unreadAlarms.isEmpty {
                        Section(header: Text("읽지않음")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal)) {
                                ForEach(viewModel.unreadAlarms) { alarm in
                                    AlarmRow(item: alarm)
                                }
                        }
                    }

                    Section(header: Text("최근 7일")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal)) {
                            ForEach(viewModel.recentAlarms) { alarm in
                                AlarmRow(item: alarm)
                            }
                    }
                }
                .padding(.top)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AlarmView()
}
