//
//  ProfileViewModel.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    enum State: Equatable { case idle, saving, success, failure(String) }

    @Published var profile = Profile(
        imageData: nil,
        nickname: "",
        introduction: "",
        link: ""
    )
    @Published var state: State = .idle

    // 편집 버퍼 (텍스트필드 바인딩)
    @Published var editingNickname: String = ""
    @Published var editingIntroduction: String = ""
    @Published var editingLink: String = ""
    @Published var editingImageData: Data?

    init() {
        loadForEdit()
    }

    func loadForEdit() {
        editingNickname      = profile.nickname
        editingIntroduction  = profile.introduction
        editingLink          = profile.link
        editingImageData     = profile.imageData
    }

    func save() async {
        guard validate() else { return }
        state = .saving

        // ✅ 지금은 서버 없음: 저장 흉내 + 0.2초 딜레이
        try? await Task.sleep(nanoseconds: 200_000_000)
        profile.nickname     = editingNickname
        profile.introduction = editingIntroduction
        profile.link         = editingLink
        profile.imageData    = editingImageData

        state = .success
    }

    private func validate() -> Bool {
        if editingNickname.trimmingCharacters(in: .whitespaces).isEmpty {
            state = .failure("닉네임을 입력해 주세요.")
            return false
        }
        if editingNickname.count > 20 {
            state = .failure("닉네임은 20자 이하로 입력해 주세요.")
            return false
        }
        return true
    }
}
