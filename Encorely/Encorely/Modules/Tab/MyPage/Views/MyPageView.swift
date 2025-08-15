import SwiftUI
import Combine

struct MyPageView: View {
    @EnvironmentObject private var router: MyPageRouter 
    // ✅ Encorely 구조에 맞춰 값기반 네비게이션 제거 → Route/Binding path 제거
    @StateObject private var vm = MyPageViewModel()

    // 팔로워/팔로잉 숫자 갱신용(이미 쓰던 것 유지)
    @StateObject private var followSummary = FollowSummaryViewModel(repo: StubFollowRepository.shared)

    private let horizontalPadding: CGFloat = 16
    private let columnSpacing: CGFloat = 8

    @Environment(\.dismiss) private var dismiss   // ← 상단 뒤로가기 대응(필요 시)

    var body: some View {
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
        .onReceive(NotificationCenter.default.publisher(for: .followListDidChange)) { _ in
            Task { await followSummary.refresh() }
        }
    }
}

// MARK: - Subviews
private extension MyPageView {

    var topBar: some View {
        HStack {
            Button {
                // 탭 루트면 동작이 없을 수 있음. 탭 내부에서 서브로 들어온 경우엔 dismiss가 작동.
                dismiss()
            } label: {
                Image("chevronLefts")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            Spacer()
            HStack(spacing: 16) {
                // ✅ 값 기반 → 목적지 기반으로 변경
                NavigationLink(destination: SettingView()) {
                    Image("settingBtn")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                NavigationLink(destination: ScrapbookView()) {
                    Image("bookMarkBtn")
                        .resizable()
                        .frame(width: 20, height: 25)
                }
                NavigationLink(destination: AlarmView()) {
                    Image("alarmBtn")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
        }
    }

    var profileSection: some View {
        HStack(alignment: .top) {
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 85, height: 85)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 10) {
                Text(vm.username)
                    .font(.title2)
                    .fontWeight(.bold)

                VStack(alignment: .leading, spacing: 15) {
                    HStack(spacing: 10) {
                        NavigationLink(destination: FollowerListView()) {
                            Text("팔로워 \(followSummary.followerCount)")
                                .foregroundColor(.black)
                        }
                        Text("|")
                            .foregroundColor(Color("grayColorG"))
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
            Text(vm.bio).font(.body)
            Text(vm.linkText).font(.footnote).foregroundColor(.gray)
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
            Spacer()
            Spacer()
        }
        .padding(.top, 8)
    }

    func imageGrid(geometry: GeometryProxy) -> some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: columnSpacing), count: 3),
            spacing: 10
        ) {
            let images = vm.currentImages()
            ForEach(images.indices, id: \.self) { i in
                VStack(spacing: 4) {
                    Image(images[i])
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: (geometry.size.width - horizontalPadding * 2 - columnSpacing * 2) / 3,
                            height: 180
                        )
                        .clipped()

                    if vm.selectedTab == .my {
                        VStack(spacing: 2) {
                            Text("NCT127 3RD TO..")
                                .font(.caption)
                                .lineLimit(1)
                            HStack(spacing: 4) {
                                Image("location1")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                Text("올림픽공원 ...")
                                    .font(.caption2)
                                    .lineLimit(1)
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
    }
}
#Preview {
    NavigationView {
        MyPageView()
    }
}
