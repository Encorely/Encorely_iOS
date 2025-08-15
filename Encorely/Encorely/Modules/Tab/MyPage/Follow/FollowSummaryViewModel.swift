// Modules/Follow/FollowSummaryViewModel.swift
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

        // 최초 로드
        Task { await refresh() }

        // 팔로우/언팔 변경 알림 수신 → 숫자 갱신
        NotificationCenter.default.publisher(for: .followListDidChange)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                Task { await self?.refresh() }
            }
            .store(in: &cancellables)
    }

    /// 저장소에서 리스트를 받아와 개수를 계산
    func refresh() async {
        do {
            async let followers = repo.fetchFollowers()
            async let followings = repo.fetchFollowings()
            let (f, g) = try await (followers, followings)
            followerCount  = f.count
            followingCount = g.count
        } catch {
            // 실패 시 필요하면 기본값 유지
            // print("refresh error:", error)
        }
    }
}
