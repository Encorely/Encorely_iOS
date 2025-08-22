import Foundation

struct FollowUser: Identifiable, Equatable {
    let id: UUID
    var username: String
    var isFollowing: Bool
}
