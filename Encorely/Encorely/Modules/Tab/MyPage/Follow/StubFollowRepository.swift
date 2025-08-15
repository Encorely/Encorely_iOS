// Modules/Follow/StubFollowRepository.swift
import Foundation

final class StubFollowRepository: FollowRepository {
    static let shared = StubFollowRepository()

    private init() {}

    // 메모리 스텁 데이터
    private var followers: [FollowUser] = [
        .init(id: UUID(), username: "아이디1", isFollowing: true),
        .init(id: UUID(), username: "아이디2", isFollowing: false),
        .init(id: UUID(), username: "아이디3", isFollowing: true)
    ]

    private var followings: [FollowUser] = [
        .init(id: UUID(), username: "팔로잉A", isFollowing: true),
        .init(id: UUID(), username: "팔로잉B", isFollowing: true),
        .init(id: UUID(), username: "팔로잉C", isFollowing: false)
    ]

    func fetchFollowers() async throws -> [FollowUser] {
        try await Task.sleep(nanoseconds: 150_000_000)
        return followers
    }

    func fetchFollowings() async throws -> [FollowUser] {
        try await Task.sleep(nanoseconds: 150_000_000)
        return followings
    }

    func postFollow(userId: UUID, follow: Bool) async throws {
        try await Task.sleep(nanoseconds: 80_000_000)

        if let idx = followers.firstIndex(where: { $0.id == userId }) {
            followers[idx].isFollowing = follow
        }
        if let idx = followings.firstIndex(where: { $0.id == userId }) {
            followings[idx].isFollowing = follow
        }

        // 숫자/리스트 갱신을 위해 방송
        NotificationCenter.default.post(name: .followListDidChange, object: nil)
    }
}
