//
//  FnbReviewDTO.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import Foundation

//MARK: - response 래퍼
struct RestaurantReviewResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [RestaurantReviewItem]
}

//MARK: - response item
struct RestaurantReviewItem: Decodable {
    let restaurantId: Int
    let userId: Int
    let userImageUrl: String
    let hallName: String
    let distance: Int
    let scrapCount: Int
    let restaurantName: String
    let latitude: String
    let longitude: String
    let imageUrl: String
    let restaurantDetail: String
    let keywords: [String]
    let numOfKeywords: Int
    let likeCount: Int
    let commentCount: Int
}

//MARK: - 내부 모델
struct FnbReview: Identifiable, Equatable {
    
    let id: Int
    let userId: Int
    let userImageUrl: String
    let hallName: String
    let distance: Int
    let scrapCount: Int
    let restaurantName: String
    let latitude: String
    let longitude: String
    let imageUrl: String?
    let restaurantDetail: String
    let keywords: [String]
    let numOfKeywords: Int
    let likeCount: Int
    let commentCount: Int
}

extension FnbReview {
    init(dto: RestaurantReviewItem) {
        self.id = dto.restaurantId
        self.userId = dto.userId
        self.userImageUrl = dto.userImageUrl
        self.hallName = dto.hallName
        self.distance = dto.distance
        self.scrapCount = dto.scrapCount
        self.restaurantName = dto.restaurantName
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        self.imageUrl = dto.imageUrl.isEmpty ? nil : dto.imageUrl
        //self.imageUrl = dto.imageUrl.isEmpty ? [] : [dto.imageUrl]
        self.restaurantDetail = dto.restaurantDetail
        self.keywords = dto.keywords
        self.numOfKeywords = dto.numOfKeywords
        self.likeCount = dto.likeCount
        self.commentCount = dto.commentCount
    }
}
