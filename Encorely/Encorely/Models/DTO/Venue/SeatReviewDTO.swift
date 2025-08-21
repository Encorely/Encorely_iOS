//
//  SeatReviewDTO.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import Foundation

//MARK: - response 래퍼
struct SeatReviewResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SeatReviewPage
}

// MARK: - 페이징 정보, 리뷰 리스트
struct SeatReviewPage: Decodable {
    let totalPages: Int
    let totalElements: Int
    let size: Int
    let content: [SeatReviewItem]
    let number: Int
    let sort: [SortInfo]
    let numberOfElements: Int
    let pageable: Pageable
    let first: Bool
    let last: Bool
    let empty: Bool
}

//MARK: - response item
struct SeatReviewItem: Decodable {
    let reviewId: Int
    let userId: Int
    let userImageUrl: String
    let hallName: String
    let seatArea: String
    let seatRow: String
    let seatNumber: String
    let rating: Int
    let scrapCount: Int
    let commentCount: Int
    let likeCount: Int
    let imageUrls: [String]
    let showDetail: String
    let keywords: [String]
    let numOfKeywords: Int
}

// MARK: - SortInfo
struct SortInfo: Decodable {
    let direction: String
    let nullHandling: String
    let ascending: Bool
    let property: String
    let ignoreCase: Bool
}

// MARK: - Pageable
struct Pageable: Decodable {
    let offset: Int
    let sort: [SortInfo]
    let pageSize: Int
    let paged: Bool
    let pageNumber: Int
    let unpaged: Bool
}

//MARK: - 내부 모델
struct SeatReview: Identifiable, Equatable {
    let id: Int
    let userId: Int
    let userImageUrl: String
    let hallName: String
    let seatArea: String
    let seatRow: String
    let seatNumber: String
    let rating: Int
    let scrapCount: Int
    let commentCount: Int
    let likeCount: Int
    let imageUrls: [String]
    let showDetail: String
    let keywords: [String]
}

extension SeatReview {
    init(dto: SeatReviewItem) {
        self.id = dto.reviewId
        self.userId = dto.userId
        self.userImageUrl = dto.userImageUrl
        self.hallName = dto.hallName
        self.seatArea = dto.seatArea
        self.seatRow = dto.seatRow
        self.seatNumber = dto.seatNumber
        self.rating = dto.rating
        self.scrapCount = dto.scrapCount
        self.commentCount = dto.commentCount
        self.likeCount = dto.likeCount
        self.imageUrls = dto.imageUrls
        self.showDetail = dto.showDetail
        self.keywords = dto.keywords
    }
}
