
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
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                topBar
                    .padding(.horizontal, 16)
                profileSection
                    .padding(.horizontal, 16)
                
                bioSection
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        tabBar
                        imageGrid(geometry: geometry)
                    }
                    .padding(.top, 5)
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
        .enableWindowTapToHideKeyboard()
    }
}

// MARK: - Subviews
private extension MyPageView {
    var displayName: String { profile?.nickname ?? vm.username }
    var displayBio: String { profile?.introduction ?? vm.bio }
    var displayLink: String { profile?.link ?? vm.linkText }
    
    var topBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image("chevronLefts")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.grayColorA)
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
        VStack(spacing: 5) {
            HStack(spacing: 15) {
                
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
                        .font(.mainTextSemiBold20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack(spacing: 10) {
                            NavigationLink(destination: FollowerListView()) {
                                Text("팔로워")
                                    .foregroundColor(.black)
                                    .font(.mainTextMedium14)
                                Text("\(followSummary.followerCount)")
                                    .foregroundColor(.black)
                                    .font(.mainTextSemiBold16)
                            }
                            Text("|").foregroundColor(Color("grayColorG"))
                            NavigationLink(destination: FollowingListView()) {
                                Text("팔로잉")
                                    .foregroundColor(.black)
                                    .font(.mainTextMedium14)
                                Text("\(followSummary.followingCount)")
                                    .foregroundColor(.black)
                                    .font(.mainTextSemiBold16)
                            }
                            Spacer()
                        }
                    }
                }
            }
            HStack(spacing: 8) {
                Text("내가 본 공연 수: \(vm.seenCount)")
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(Color.mainColorH)
                    .cornerRadius(100)
                    .font(.mainTextMedium14)
                
                NavigationLink(destination: ProfileSettingView()) {
                    Text("프로필 편집")
                        .padding(.horizontal, 9)
                        .padding(.vertical, 5)
                        .background(Color.mainColorH)
                        .cornerRadius(100)
                        .font(.mainTextMedium14)
                        .foregroundStyle(Color.grayColorA)
                }
            }
            .padding(.leading, 30)
        }
    }
    
    var bioSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(displayBio)
                .font(.mainTextMedium14)
            
            Text(displayLink)
                .font(.mainTextMedium14)
                .foregroundColor(.gray)
        }
    }
    
    var tabBar: some View {
        HStack(spacing: 16) {
            Button { vm.selectedTab = .my } label: {
                VStack(spacing: 15) {
                    Text("My Encorely")
                        .font(.mainTextMedium18)
                        .foregroundColor(vm.selectedTab == .my ? .black : .gray)
                    Capsule()
                        .fill(vm.selectedTab == .my ? Color("mainColorA") : .clear)
                        .frame(height: 3)
                }
            }
            Button { vm.selectedTab = .friend } label: {
                VStack(spacing: 15) {
                    Text("Friend Encorely")
                        .font(.mainTextMedium18)
                        .foregroundColor(vm.selectedTab == .friend ? .black : .gray)
                    Capsule()
                        .fill(vm.selectedTab == .friend ? Color("mainColorA") : .clear)
                        .frame(height: 3)
                }
            }
            Spacer()
        }
        .padding(.top, 8)
    }
    
    func imageGrid(geometry: GeometryProxy) -> some View {
        // 가로 간격 0, 3열 그리드
        let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
        
        return LazyVGrid(
            columns: columns,
            spacing: 0
        ) {
            let images = vm.currentImages()
            ForEach(images.indices, id: \.self) { i in
                Button(action: {
                    
                }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Image(images[i])
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: (geometry.size.width) / 3
                            )
                            .clipped()
                        
                        if vm.selectedTab == .my {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("NCT127 3RD TO..")
                                    .font(.mainTextMedium14)
                                    .foregroundStyle(Color.grayColorA)
                                    .lineLimit(1)
                                
                                HStack(spacing: 5) {
                                    Image("location1").resizable().frame(width: 11, height: 14)
                                    
                                    Text("올림픽공원 ...")
                                        .font(.mainTextMedium14)
                                        .foregroundStyle(Color.grayColorA)
                                        .lineLimit(1)
                                }
                                
                            }
                            .padding(.horizontal, 9)
                            .padding(.top, 3)
                            .padding(.bottom, 10)
                        } else {
                            VStack(spacing: 5) {
                                if i < vm.friendNicknames.count {
                                    Text(vm.friendNicknames[i])
                                        .font(.mainTextMedium14)
                                        .foregroundStyle(Color.grayColorA)
                                        .lineLimit(1)
                                }
                                if i < vm.friendConcertTitles.count {
                                    Text(vm.friendConcertTitles[i])
                                        .font(.mainTextMedium14)
                                        .foregroundStyle(Color.grayColorA)
                                        .lineLimit(1)
                                }
                            }
                            .padding(.horizontal, 9)
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    NavigationStack { MyPageView() }
}
