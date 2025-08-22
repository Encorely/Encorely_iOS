import Foundation
import Combine

@MainActor
final class FollowSummaryViewModel: ObservableObject {
    @Published var followerCount: Int = 0
    @Published var followingCount: Int = 0

    private let repo: FollowRepository
    private var cancellables = Set<AnyCancellable>()

    init(repo: FollowRepository = StubFollowRepository.shared) {
        self.repo = repo
        Task { await refresh() }
        NotificationCenter.default.publisher(for: .followListDidChange)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                Task { await self?.refresh() }
            }
            .store(in: &cancellables)
    }

    func refresh() async {
        do {
            async let followers = repo.fetchFollowers()
            async let followings = repo.fetchFollowings()
            let (f, g) = try await (followers, followings)

            // 팔로워 수 = 내가 맞팔한 사람 수(버튼이 "팔로잉" = 하얀 버튼)
            followerCount = f.filter { $0.isFollowing }.count

            // 팔로잉 수는 기존 로직 유지(원하면 .filter { $0.isFollowing } 로 바꿔도 됨)
            followingCount = g.count
        } catch {
            // 실패 시 기존 값 유지
        }
    }
}
