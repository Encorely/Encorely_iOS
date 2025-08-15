// Modules/Follow/FollowRepository.swift
import Foundation

protocol FollowRepository {
    func fetchFollowers() async throws -> [FollowUser]
    func fetchFollowings() async throws -> [FollowUser]
    /// follow == true  → 팔로우
    /// follow == false → 언팔로우
    func postFollow(userId: UUID, follow: Bool) async throws
}
