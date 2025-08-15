// Modules/Follow/FollowNotifications.swift
import Foundation

extension Notification.Name {
    /// 팔로워/팔로잉 리스트가 변경되었을 때 방송되는 공용 노티
    static let followListDidChange = Notification.Name("followListDidChange")
}
