// Modules/Follow/FollowingListViewModel.swift
import Foundation

@MainActor
final class FollowingListViewModel: ObservableObject {
    @Published var followings: [FollowUser] = []
    private let repo: FollowRepository

    init(repo: FollowRepository = StubFollowRepository.shared) {
        self.repo = repo
    }

    func load() async {
        do { followings = try await repo.fetchFollowings() }
        catch { print("fetchFollowings error:", error) }
    }

    func toggle(at index: Int) {
        guard followings.indices.contains(index) else { return }
        let user = followings[index]
        let newFollow = !user.isFollowing
        followings[index].isFollowing = newFollow
        Task {
            do { try await repo.postFollow(userId: user.id, follow: newFollow) }
            catch { print("postFollow error:", error) }
        }
    }
}
