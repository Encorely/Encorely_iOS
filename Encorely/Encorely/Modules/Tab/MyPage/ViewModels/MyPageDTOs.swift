//
//  MyPageDTOs.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

// 나중에 실제 API 응답 DTO가 생기면 여기에 Codable 구조체 추가.
// 지금은 화면에서 쓰기 쉬운 Domain 모델만 사용.
struct MyPageData {
    let username: String
    let bio: String
    let linkText: String
    let myEncorelyImages: [String]
    let friendEncorelyImages: [String]
    let friendNicknames: [String]
    let friendConcertTitles: [String]
    let seenCount: Int
}
