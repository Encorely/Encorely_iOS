import Foundation

final class StubFollowRepository: FollowRepository {
    static let shared = StubFollowRepository()
    private init() {}

    // 팔로워: 나를 팔로우하는 사람들(내가 맞팔했는지 isFollowing 플래그로 구분)
    private var followers: [FollowUser] = [
        .init(id: UUID(), username: "아이디1",  isFollowing: true),
        .init(id: UUID(), username: "아이디2",  isFollowing: true),
        .init(id: UUID(), username: "아이디3",  isFollowing: true),
        .init(id: UUID(), username: "아이디4",  isFollowing: true),
        .init(id: UUID(), username: "아이디5",  isFollowing: true),
        .init(id: UUID(), username: "아이디6",  isFollowing: true)
    ]

    // 팔로잉: 내가 팔로우 중인 사람들(여기는 기본적으로 모두 isFollowing == true)
    private var followings: [FollowUser] = [
        .init(id: UUID(), username: "팔로잉A", isFollowing: true),
        .init(id: UUID(), username: "팔로잉B", isFollowing: true),
        .init(id: UUID(), username: "팔로잉C", isFollowing: true),
        .init(id: UUID(), username: "팔로잉D", isFollowing: true),
        .init(id: UUID(), username: "팔로잉E", isFollowing: true),
        .init(id: UUID(), username: "팔로잉F", isFollowing: true),
        .init(id: UUID(), username: "팔로잉G", isFollowing: true),
        .init(id: UUID(), username: "팔로잉H", isFollowing: true),
        .init(id: UUID(), username: "팔로잉I", isFollowing: true),
        .init(id: UUID(), username: "팔로잉J", isFollowing: true),
        .init(id: UUID(), username: "팔로잉K", isFollowing: true),
        .init(id: UUID(), username: "팔로잉L", isFollowing: true)
    ]

    func fetchFollowers() async throws -> [FollowUser] {
        try await Task.sleep(nanoseconds: 150_000_000)
        return followers
    }

    func fetchFollowings() async throws -> [FollowUser] {
        try await Task.sleep(nanoseconds: 150_000_000)
        // 방어적으로 true만 반환(팔로잉 리스트는 '현재 팔로우 중'만 보여야 하니까)
        return followings.filter { $0.isFollowing }
    }

    func postFollow(userId: UUID, follow: Bool) async throws {
        try await Task.sleep(nanoseconds: 80_000_000)

        // 1) 팔로워 목록의 맞팔 플래그 동기화
        if let idx = followers.firstIndex(where: { $0.id == userId }) {
            followers[idx].isFollowing = follow
        }

        // 2) 팔로잉 목록 갱신
        if follow {
            // 없으면 추가
            if followings.firstIndex(where: { $0.id == userId }) == nil {
                if let f = followers.first(where: { $0.id == userId }) {
                    followings.append(.init(id: f.id, username: f.username, isFollowing: true))
                } else {
                    followings.append(.init(id: userId, username: "새친구", isFollowing: true))
                }
            } else {
                // 있으면 true로 보정
                if let idx = followings.firstIndex(where: { $0.id == userId }) {
                    followings[idx].isFollowing = true
                }
            }
        } else {
            // 언팔: 팔로잉 목록에서 제거
            if let idx = followings.firstIndex(where: { $0.id == userId }) {
                followings.remove(at: idx)
            }
        }

        // 3) 상단 집계/다른 화면 갱신
        NotificationCenter.default.post(name: .followListDidChange, object: nil)
    }
}
