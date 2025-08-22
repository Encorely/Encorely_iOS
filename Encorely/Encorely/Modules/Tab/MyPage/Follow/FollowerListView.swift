import SwiftUI

struct FollowerListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = FollowerListViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button { dismiss() } label: {
                    Image("chevronLeft").resizable().frame(width: 30, height: 30)
                }
                Spacer()
                Text("팔로워 리스트").font(.headline)
                Spacer()
                Color.clear.frame(width: 30, height: 30)
            }
            .padding().background(Color.white)
            Divider()

            List {
                ForEach(Array(vm.followers.enumerated()), id: \.element.id) { idx, user in
                    HStack(spacing: 12) {
                        Circle().fill(.gray.opacity(0.5)).frame(width: 50, height: 50)
                        Text(user.username).foregroundStyle(.black)
                        Spacer()
                        Button {
                            vm.toggle(at: idx)
                        } label: {
                            Text(user.isFollowing ? "팔로잉" : "팔로우")
                                .foregroundStyle(user.isFollowing ? .black : .white)
                                .padding(.horizontal, 14).padding(.vertical, 6)
                                .background(
                                    user.isFollowing
                                    ? AnyView(RoundedRectangle(cornerRadius: 100).stroke(.blue))
                                    : AnyView(RoundedRectangle(cornerRadius: 100).fill(.blue))
                                )
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(height: 60)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationBarHidden(true)
        .task { await vm.load() }
    }
}

#Preview { NavigationStack { FollowerListView() } }
