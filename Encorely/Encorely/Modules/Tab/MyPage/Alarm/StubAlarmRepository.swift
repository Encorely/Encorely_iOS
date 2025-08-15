//
//  StubAlarmRepository.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

final class StubAlarmRepository: AlarmRepository {
    func fetchUnreadAlarms() async throws -> [AlarmItem] {
        return [
            AlarmItem(id: UUID(), content: "OO님이 회원님의 글을 스크랩했어요.", date: "6/30 | 12:00"),
            AlarmItem(id: UUID(), content: "OO님이 댓글을 남겼어요.", date: "6/31 | 12:00")
        ]
    }

    func fetchRecentAlarms() async throws -> [AlarmItem] {
        return [
            AlarmItem(id: UUID(), content: "OO님이 회원님의 글을 스크랩했어요.", date: "6/30 | 12:00"),
            AlarmItem(id: UUID(), content: "OO님이 댓글을 남겼어요.", date: "6/31 | 12:00"),
            AlarmItem(id: UUID(), content: "OO님이 회원님의 글을 좋아합니다.", date: "6/31 | 12:00")
        ]
    }
}
