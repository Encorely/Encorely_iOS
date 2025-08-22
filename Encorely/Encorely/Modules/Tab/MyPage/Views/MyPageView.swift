import SwiftUI
import Combine
import UIKit

struct MyPageView: View {
    @EnvironmentObject private var router: MyPageRouter
    @StateObject private var vm = MyPageViewModel()
    @StateObject private var followSummary = FollowSummaryViewModel(repo: StubFollowRepository.shared)

    @State private var profile: UserProfile? = ProfileStore.shared.load()

    private let horizontalPadding: CGFloat = 16
    private let columnSpacing: CGFloat = 8

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        topBar
                        profileSection
                        bioSection
                        tabBar
                        imageGrid(geometry: geometry)
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                }
            }
            .task {
                await vm.load()
                await followSummary.refresh()
            }
            .onAppear { profile = ProfileStore.shared.load() }
            .onReceive(NotificationCenter.default.publisher(for: .profileDidChange)) { _ in
                profile = ProfileStore.shared.load()
            }
        }
    }
}

// MARK: - Subviews
private extension MyPageView {
    var displayName: String { profile?.nickname ?? vm.username }
    var displayBio: String { profile?.introduction ?? vm.bio }
    var displayLink: String { profile?.link ?? vm.linkText }

    var topBar: some View {
        HStack {
            Button { dismiss() } label: {
                Image("chevronLefts").resizable().frame(width: 30, height: 30)
            }
            Spacer()
            HStack(spacing: 16) {
                NavigationLink(destination: SettingView()) {
                    Image("settingBtn").resizable().frame(width: 25, height: 25)
                }
                NavigationLink(destination: ScrapbookView()) {
                    Image("bookMarkBtn").resizable().frame(width: 20, height: 25)
                }
                NavigationLink(destination: AlarmView()) {
                    Image("alarmBtn").resizable().frame(width: 25, height: 25)
                }
            }
        }
    }

    var profileSection: some View {
        HStack(alignment: .top) {

            Group {
                if let data = profile?.imageData, let ui = UIImage(data: data) {
                    Image(uiImage: ui)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 85, height: 85)
                        .clipShape(Circle())
                } else {
                    ZStack {
                        Circle()
                            .fill(Color("grayColorH"))
                            .frame(width: 85, height: 85)
                        Image("Nothing")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 68, height: 68)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(displayName)
                    .font(.title2).fontWeight(.bold)

                VStack(alignment: .leading, spacing: 15) {
                    HStack(spacing: 10) {
                        NavigationLink(destination: FollowerListView()) {
                            Text("팔로워 \(followSummary.followerCount)")
                                .foregroundColor(.black)
                        }
                        Text("|").foregroundColor(Color("grayColorG"))
                        NavigationLink(destination: FollowingListView()) {
                            Text("팔로잉 \(followSummary.followingCount)")
                                .foregroundColor(.black)
                        }
                    }

                    HStack(spacing: 8) {
                        Text("내가 본 공연 수: \(vm.seenCount)")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color("mainColorH"))
                            .cornerRadius(12)

                        NavigationLink(destination: ProfileSettingView()) {
                            Text("프로필 편집")
                                .padding(.horizontal, 10)
                                .foregroundColor(.black)
                                .padding(.vertical, 4)
                                .background(Color("mainColorH"))
                                .cornerRadius(12)
                        }
                    }
                    .font(.caption)
                }
            }
            Spacer()
        }
    }

    var bioSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(displayBio).font(.body)
            Text(displayLink).font(.footnote).foregroundColor(.gray)
        }
    }

    var tabBar: some View {
        HStack(spacing: 16) {
            Button { vm.selectedTab = .my } label: {
                VStack(spacing: 4) {
                    Text("My Encorely")
                        .fontWeight(.semibold)
                        .foregroundColor(vm.selectedTab == .my ? .black : .gray)
                    Capsule()
                        .fill(vm.selectedTab == .my ? Color("mainColorA") : .clear)
                        .frame(height: 3)
                }
            }
            Button { vm.selectedTab = .friend } label: {
                VStack(spacing: 4) {
                    Text("Friend Encorely")
                        .fontWeight(.semibold)
                        .foregroundColor(vm.selectedTab == .friend ? .black : .gray)
                    Capsule()
                        .fill(vm.selectedTab == .friend ? Color("mainColorA") : .clear)
                        .frame(height: 3)
                }
            }
            Spacer(); Spacer()
        }
        .padding(.top, 8)
    }

    func imageGrid(geometry: GeometryProxy) -> some View {
        // 가로 간격 0, 3열 그리드
        let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)

        return LazyVGrid(
            columns: columns,
            spacing: 10 // 세로 간격은 유지 (원하면 0으로)
        ) {
            let images = vm.currentImages()
            ForEach(images.indices, id: \.self) { i in
                VStack(spacing: 4) {
                    Image(images[i])
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)   // 너비는 그리드가 꽉 채움
                        .clipped()

                    if vm.selectedTab == .my {
                        VStack(spacing: 2) {
                            Text("NCT127 3RD TO..").font(.caption).lineLimit(1)
                            HStack(spacing: 4) {
                                Image("location1").resizable().frame(width: 10, height: 10)
                                Text("올림픽공원 ...").font(.caption2).lineLimit(1)
                            }
                        }
                    } else {
                        VStack(spacing: 2) {
                            if i < vm.friendNicknames.count {
                                Text(vm.friendNicknames[i]).font(.caption).lineLimit(1)
                            }
                            if i < vm.friendConcertTitles.count {
                                Text(vm.friendConcertTitles[i]).font(.caption2).lineLimit(1)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, -horizontalPadding)
    }
}

#Preview {
    NavigationStack { MyPageView() }
}
