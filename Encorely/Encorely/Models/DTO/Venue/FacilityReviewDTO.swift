//
//  FacilityReviewDTO.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import Foundation

//MARK: - response 래퍼
struct FacilityReviewResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [FacilityReviewItem]
}

//MARK: - response item
struct FacilityReviewItem: Decodable {
    let facilityId: Int
    let userId: Int
    let userImageUrl: String
    let hallName: String
    let scrapCount: Int
    let facilityName: String
    let latitude: String
    let longitude: String
    let imageUrl: String
    let tips: String
    let likeCount: Int
    let commentCount: Int
}

//MARK: - 내부 모델
struct FacilityReview: Identifiable, Equatable {
    
    let id: Int
    let userId: Int
    let userImageUrl: String
    let hallName: String
    let scrapCount: Int
    let facilityName: String
    let latitude: String
    let longitude: String
    let imageUrl: String?
    let tips: String
    let likeCount: Int
    let commentCount: Int
}

extension FacilityReview {
    init(dto: FacilityReviewItem) {
        self.id = dto.facilityId
        self.userId = dto.userId
        self.userImageUrl = dto.userImageUrl
        self.hallName = dto.hallName
        self.scrapCount = dto.scrapCount
        self.facilityName = dto.facilityName
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        self.imageUrl = dto.imageUrl.isEmpty ? nil : dto.imageUrl
        ///self.imageUrl = dto.imageUrl.isEmpty ? [] : [dto.imageUrl] ///여러 장일 경우, 한 장일 경우, 없을 경우 대비
        self.tips = dto.tips
        self.likeCount = dto.likeCount
        self.commentCount = dto.commentCount
    }
}
