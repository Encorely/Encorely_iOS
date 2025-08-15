//
//  ReviewDTO.swift
//  Encorely
//
//  Created by 이예지 on 8/4/25.
//

import Foundation

// MARK: Generic API Response
struct APIResponse<T: Codable>: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T
}

// MARK: 후기 등록
/// 후기 등록 request
struct RegistReviewElement: Codable {
    // 공연 정보
    let showDate: String
    let round: Int
    let showName: String
    let artistName: String
    
    // 공연장 정보
    let hallId: Int
    
    // 좌석 정보
    let seatArea: String
    let seatRow: String
    let seatNumber: String
    let seatRating: Int
    let consAndProsList: String
    let seatDetail: String?
    
    // 공연 후기
    let comment: String
    let showDetail: String?
    
    // 이미지 정보
    let reviewImageInfos: [ReviewImageInfo]
    
    // 맛집 정보 (선택사항)
    let restaurantInfos: [RestaurantInfo]?
    
    // 편의시설 정보 (선택사항)
    let facilityInfos: [FacilityInfo]?
}

struct ReviewImageInfo: Codable {
    let imageUrl: String
    let imageType: String
}

struct RestaurantInfo: Codable {
    let restaurantType: String
    let name: String
    let address: String
    let latitude: String
    let longitude: String
    let restaurantDetail: String
    let imageUrl: String
    let restaurantProsList: String
}

struct FacilityInfo: Codable {
    let facilityType: String
    let name: String
    let address: String
    let latitude: String
    let longitude: String
    let tips: String
    let imageUrl: String
}

/// 후기 등록 response
typealias RegistReviewResponse = APIResponse<RegistReviewElement>


// MARK: 후기 수정
/// 후기 수정 response
typealias UpdateReviewResponse = APIResponse<String>


// MARK: 후기 삭제
/// 후기 수정 response
typealias DeleteReviewResponse = APIResponse<String>


// MARK: 후기 조회
/// 후기 조회 response
typealias RetrieveReviewResponse = APIResponse<ReviewDetailResult>

struct ReviewDetailResult: Codable {
    let reviewId: Int
    let nickname: String
    let date: String
    let round: Int
    let showName: String
    let showImages: [ShowImage]
    let comment: String
    let showDetail: String
    let viewImages: [ViewImage]
    let hallId: Int
    let hallName: String
    let seatArea: String
    let seatRow: String
    let seatNumber: String
    let rating: Int
    let seatDetail: String
    let seatKeywords: [SeatKeyword]
    let restaurants: [Restaurant]
    let facilities: [Facility]
    let likeCount: Int
    let commentCount: Int
}

struct ShowImage: Codable {
      let imageId: Int
      let imageUrl: String
}

struct ViewImage: Codable {
      let imageId: Int
      let imageUrl: String
}

struct SeatKeyword: Codable {
    let keywordId: Int
    let content: String
}

struct Restaurant: Codable {
    let restaurantId: Int
    let restaurantType: String
    let image: [RestaurantImage]
    let restaurantName: String
    let address: String
    let latitude: String
    let longitude: String
    let restaurantDetail: String
    let restaurantKeywords: [RestaurantKeyword]
}

struct RestaurantImage: Codable {
    let imageId: Int
    let imageUrl: String
}

struct RestaurantKeyword: Codable {
    let keywordId: Int
    let content: String
}

struct Facility: Codable {
    let facilityId: Int
    let facilityType: String
    let image: [FacilityImage]
    let facilityName: String
    let address: String
    let latitude: String
    let longitude: String
    let tips: String
}

struct FacilityImage: Codable {
    let imageId: Int
    let imageUrl: String
}

// MARK: 후기 이미지 삭제
/// 후기 이미지 삭제 response
typealias DeleteReviewImageResponse = APIResponse<String>


// MARK: 화제의 후기들
/// 화제의 후기들 response
typealias ReviewRankingResponse = APIResponse<ReviewRankingResult>

struct ReviewRankingResult: Codable {
    let reviewId: Int
    let reviewImageUrl: String
    let userProfileImageUrl: String
    let nickname: String
    let comment: String
}
