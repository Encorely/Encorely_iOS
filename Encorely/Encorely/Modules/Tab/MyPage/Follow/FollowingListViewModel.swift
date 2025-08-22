import Foundation

@MainActor
final class FollowingListViewModel: ObservableObject {
    @Published var followings: [FollowUser] = []
    private let repo: FollowRepository

    init(repo: FollowRepository = StubFollowRepository.shared) {
        self.repo = repo
    }

    func load() async {
        do { followings = try await repo.fetchFollowings() }  // 이미 "현재 팔로잉 중"만 내려옴
        catch { print("fetchFollowings error:", error) }
    }

    func toggle(at index: Int) {
        guard followings.indices.contains(index) else { return }
        let user = followings[index]

        if user.isFollowing {
            let removed = followings.remove(at: index)           // UI에서 즉시 제거
            Task {
                do { try await repo.postFollow(userId: removed.id, follow: false) } // 언팔
                catch { print("postFollow error:", error) }
            }
        } else {
            // 이 경로는 원칙적으로 나타나지 않지만 방어적으로 처리
            followings[index].isFollowing = true
            Task {
                do { try await repo.postFollow(userId: user.id, follow: true) }
                catch { print("postFollow error:", error) }
            }
        }
    }
}
