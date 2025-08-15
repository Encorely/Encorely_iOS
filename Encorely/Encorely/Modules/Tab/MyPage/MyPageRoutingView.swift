//
//  MyPageRoutingView.swift
//  Encorely
//
//  Created by Kehyuk on 8/13/25.
//

import SwiftUI

/// MyPage 탭 전용 NavigationStack (탭 외부에는 영향 없음)
struct MyPageRoutingView: View {
    @StateObject private var router = MyPageRouter()

    var body: some View {
        NavigationStack(path: $router.path) {
            // 루트: MyPageView
            MyPageView()
                .environmentObject(router)
                .navigationDestination(for: MyPageRoute.self) { route in
                    switch route {
                    case .setting:         SettingView()
                    case .scrapbook:       ScrapbookView()
                    case .alarm:           AlarmView()
                    case .followerList:    FollowerListView()
                    case .followingList:   FollowingListView()
                    case .profileSetting:  ProfileSettingView()

                    case .basicFolder:     BasicFolderView()
                    case .myFolder1:       MyFolder1View()

                    case .notice:          NoticeView()
                    case .blockedList:     BlockedListView()
                    }
                }
        }
    }
}
