// Modules/Follow/FollowerListViewModel.swift
import Foundation

@MainActor
final class FollowerListViewModel: ObservableObject {
    @Published var followers: [FollowUser] = []
    private let repo: FollowRepository

    init(repo: FollowRepository = StubFollowRepository.shared) {
        self.repo = repo
    }

    func load() async {
        do { followers = try await repo.fetchFollowers() }
        catch { print("fetchFollowers error:", error) }
    }

    func toggle(at index: Int) {
        guard followers.indices.contains(index) else { return }
        let user = followers[index]
        let newFollow = !user.isFollowing
        followers[index].isFollowing = newFollow   // 낙관적 업데이트
        Task {
            do { try await repo.postFollow(userId: user.id, follow: newFollow) }
            catch { print("postFollow error:", error) }
        }
    }
}
