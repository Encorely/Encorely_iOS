import Foundation

protocol FollowRepository {
    func fetchFollowers() async throws -> [FollowUser]
    func fetchFollowings() async throws -> [FollowUser]
    func postFollow(userId: UUID, follow: Bool) async throws
}
