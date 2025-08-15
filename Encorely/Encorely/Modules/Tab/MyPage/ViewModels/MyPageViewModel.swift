//
//  MyPageViewModel.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

@MainActor
final class MyPageViewModel: ObservableObject {

    enum Tab { case my, friend }

    enum State {
        case idle
        case loading
        case loaded
        case failure(String)
    }

    // MARK: - Published UI State
    @Published var state: State = .idle
    @Published var selectedTab: Tab = .my

    // 서버/레포 응답을 화면이 바로 쓰기 쉽게 보관
    @Published var username: String = "KPOP_lover"
    @Published var bio: String = "내 인생은 콘서트 전과 후로 나뉜다."
    @Published var linkText: String = "@링크"
    @Published var myEncorelyImages: [String] = []
    @Published var friendEncorelyImages: [String] = []
    @Published var friendNicknames: [String] = []
    @Published var friendConcertTitles: [String] = []
    @Published var seenCount: Int = 0

    // MARK: - Dependencies
    private let repo: MyPageRepository

    init(repo: MyPageRepository = StubMyPageRepository()) {
        self.repo = repo
    }

    // MARK: - Intents
    func load() async {
        state = .loading
        do {
            let data = try await repo.fetchMyPage()
            apply(data)
            state = .loaded
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func currentImages() -> [String] {
        selectedTab == .my ? myEncorelyImages : friendEncorelyImages
    }

    // MARK: - Private
    private func apply(_ data: MyPageData) {
        username = data.username
        bio = data.bio
        linkText = data.linkText
        myEncorelyImages = data.myEncorelyImages
        friendEncorelyImages = data.friendEncorelyImages
        friendNicknames = data.friendNicknames
        friendConcertTitles = data.friendConcertTitles
        seenCount = data.seenCount
    }
}
