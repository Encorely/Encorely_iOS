//
//  BlockedListViewModel.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

struct BlockedUser: Identifiable, Equatable {
    let id = UUID()
    let username: String
}

final class BlockedListViewModel: ObservableObject {
    @Published var blockedUsers: [BlockedUser] = [
        BlockedUser(username: "아이디"),
        BlockedUser(username: "아이디"),
        BlockedUser(username: "아이디"),
        BlockedUser(username: "아이디")
    ]

    func unblock(_ user: BlockedUser) {
        if let idx = blockedUsers.firstIndex(of: user) {
            blockedUsers.remove(at: idx)
        }
        // 나중에 서버 연동 시 여기서 API 호출만 추가
    }
}
