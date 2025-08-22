import Foundation
import UIKit

@MainActor
final class ProfileViewModel: ObservableObject {
    enum State: Equatable { case idle, saving, success, failure(String) }
    @Published var state: State = .idle

    // 편집 버퍼 (텍스트필드/이미지 바인딩)
    @Published var editingNickname: String = ""
    @Published var editingIntroduction: String = ""
    @Published var editingLink: String = ""
    @Published var editingImageData: Data?

    /// 저장소에서 현재 프로필을 불러와 편집 버퍼에 채움
    func loadFromStore() {
        if let saved = ProfileStore.shared.load() {
            editingNickname     = saved.nickname
            editingIntroduction = saved.introduction
            editingLink         = saved.link
            editingImageData    = saved.imageData
        } else {
            editingNickname = ""
            editingIntroduction = ""
            editingLink = ""
            editingImageData = nil
        }
    }

    /// 검증 후 저장
    func save() async {
        guard validate() else { return }
        state = .saving
        try? await Task.sleep(nanoseconds: 150_000_000) // UX용 딜레이(선택)

        let profile = UserProfile(
            nickname: editingNickname.trimmingCharacters(in: .whitespacesAndNewlines),
            introduction: editingIntroduction,
            link: editingLink,
            imageData: editingImageData
        )
        ProfileStore.shared.save(profile)   // ← 저장 + .profileDidChange 노티 발행
        state = .success
    }

    private func validate() -> Bool {
        let name = editingNickname.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else {
            state = .failure("닉네임을 입력해 주세요.")
            return false
        }
        guard name.count <= 20 else {
            state = .failure("닉네임은 20자 이하로 입력해 주세요.")
            return false
        }
        return true
    }
}
