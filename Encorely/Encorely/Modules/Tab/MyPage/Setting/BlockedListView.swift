import SwiftUI

struct BlockedListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = BlockedListViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Top Bar (UI 그대로)
            HStack {
                Button(action: { dismiss() }) {
                    Image("chevronLeft").resizable().frame(width: 30, height: 30)
                }
                Spacer()
                Text("차단된 계정").font(.headline).bold()
                Spacer()
                Color.clear.frame(width: 30, height: 30)
            }
            .padding()

            if vm.blockedUsers.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image("blockedNone").resizable().frame(width: 80, height: 80)
                    Text("차단된 사용자가 없습니다.")
                        .font(.body)
                        .foregroundColor(.black)
                }
                Spacer()
            } else {
                List {
                    ForEach(vm.blockedUsers) { user in
                        HStack {
                            Circle().fill(Color.gray.opacity(0.4)).frame(width: 40, height: 40)
                            Text(user.username).foregroundColor(.black)
                            Spacer()
                            Button(action: { vm.unblock(user) }) {
                                Text("차단 해제")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color("subColorD"))
                                    .foregroundColor(.white)
                                    .cornerRadius(100)
                            }
                        }
                        .padding(.vertical, 4)
                        .contentShape(Rectangle())
                        .listRowSeparator(.hidden)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview { BlockedListView() }
