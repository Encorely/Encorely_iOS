//
//  ReviewRankingDTO.swift
//  Encorely
//
//  Created by 이민서 on 8/13/25.
//

import Foundation

//MARK: - response 래퍼
struct ReviewRankingResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [ReviewRankingItem]
}

//MARK: - response item
struct ReviewRankingItem: Decodable {
    let reviewId: Int
    let reviewImageUrl: String
    let userProfileImageUrl: String
    let nickname: String
    let comment: String
}

//MARK: - 내부 모델
struct ReviewRanking: Identifiable, Equatable {
    let id: Int
    let reviewImageURL: String
    let userProfileImageURL: String      
    let nickname: String
    let comment: String?
}

extension ReviewRanking {
    init(dto: ReviewRankingItem) {
        self.id = dto.reviewId
        self.reviewImageURL = dto.reviewImageUrl
        self.userProfileImageURL = dto.userProfileImageUrl
        self.nickname = dto.nickname
        self.comment = dto.comment
    }
}
