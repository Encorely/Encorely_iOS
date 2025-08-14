//
//  UserRankingDTO.swift
//  Encorely
//
//  Created by 이민서 on 8/13/25.
//

import Foundation

//MARK: - response 래퍼
struct UserRankingResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [UserRankingItem]
}

//MARK: - response item
struct UserRankingItem: Decodable {
    let userId: Int
    let nickname: String
    let imageUrl: String
    let instruction: String
}

//MARK: - 내부 모델
struct UserRanking: Identifiable, Equatable {
    let id: Int
    let nickname: String
    let imageUrl: String
    let instruction: String
}

extension UserRanking {
    init(dto: UserRankingItem) {
        self.id = dto.userId
        self.nickname = dto.nickname
        self.imageUrl = dto.imageUrl
        self.instruction = dto.instruction
    }
}
