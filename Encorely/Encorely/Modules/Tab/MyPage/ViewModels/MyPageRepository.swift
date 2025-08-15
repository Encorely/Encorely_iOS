//
//  MyPageRepository.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

protocol MyPageRepository {
    func fetchMyPage() async throws -> MyPageData
}

// API 붙이기 전, 가짜 데이터로 동작 확인용
final class StubMyPageRepository: MyPageRepository {
    func fetchMyPage() async throws -> MyPageData {
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3s 딜레이

        return MyPageData(
            username: "KPOP_lover",
            bio: "내 인생은 콘서트 전과 후로 나뉜다.",
            linkText: "@링크",
            myEncorelyImages: Array(repeating: "concert_sample", count: 6),
            friendEncorelyImages: ["ivePhoto", "apinkPhoto", "exoPhoto"],
            friendNicknames: ["kasodi_ss", "kiki_akdxb", "s_wooni"],
            friendConcertTitles: ["2025 IVE THE ..", "APINK FAN CON...", "EXO WORLD.."],
            seenCount: 6
        )
    }
}
