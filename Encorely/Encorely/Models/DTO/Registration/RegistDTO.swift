//
//  RegistDTO.swift
//  Encorely
//
//  Created by 이예지 on 8/4/25.
//

import Foundation
import SwiftUI

// MARK: - 후기 등록 Request
struct ReviewRegistrationRequest: Codable {
    // 공연 정보
    let performanceDate: String
    let performanceRound: String
    let performanceTitle: String
    let artistName: String
    
    // 공연장 정보
    let venueName: String
    let venueAddress: String
    
    // 좌석 정보
    let seatZone: String
    let seatRow: String
    let seatNumber: String
    let seatRating: Int
    let goodKeywords: [String]
    let badKeywords: [String]
    let seatDetailReview: String?
    
    // 공연 후기
    let simpleReview: String
    let performanceDetailReview: String?
    
    // 맛집 정보 (선택사항)
    let restaurantType: String?
    let restaurantURL: String?
    let restaurantKeywords: [String]
    let restaurantDetailReview: String?
    
    // 편의시설 정보 (선택사항)
    let facilityType: String?
    let facilityURL: String?
    let facilityDetailReview: String?
    
    // 이미지 정보 (Base64 문자열로 전송)
    let sightImages: [ImageData]
    let performanceImages: [ImageData]
    
    enum CodingKeys: String, CodingKey {
        case performanceDate = "performance_date"
        case performanceRound = "performance_round"
        case performanceTitle = "performance_title"
        case artistName = "artist_name"
        case venueName = "venue_name"
        case venueAddress = "venue_address"
        case seatZone = "seat_zone"
        case seatRow = "seat_row"
        case seatNumber = "seat_number"
        case seatRating = "seat_rating"
        case goodKeywords = "good_keywords"
        case badKeywords = "bad_keywords"
        case seatDetailReview = "seat_detail_review"
        case simpleReview = "simple_review"
        case performanceDetailReview = "performance_detail_review"
        case restaurantType = "restaurant_type"
        case restaurantURL = "restaurant_url"
        case restaurantKeywords = "restaurant_keywords"
        case restaurantDetailReview = "restaurant_detail_review"
        case facilityType = "facility_type"
        case facilityURL = "facility_url"
        case facilityDetailReview = "facility_detail_review"
        case sightImages = "sight_images"
        case performanceImages = "performance_images"
    }
    
    // 유효성 검증
    var isValid: Bool {
        !performanceTitle.isEmpty &&
        !artistName.isEmpty &&
        !performanceDate.isEmpty &&
        !performanceRound.isEmpty &&
        !venueName.isEmpty &&
        !seatZone.isEmpty &&
        !seatRow.isEmpty &&
        !seatNumber.isEmpty &&
        seatRating > 0 &&
        !simpleReview.isEmpty
    }
}

// MARK: - 이미지 데이터 구조체
struct ImageData: Codable {
    let fileName: String
    let imageData: String // Base64 encoded
    let imageType: String // "sight" or "performance"
    
    enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
        case imageData = "image_data"
        case imageType = "image_type"
    }
}

// MARK: - 후기 등록 Response
struct ReviewRegistrationResponse: Codable {
    let reviewId: String
    let status: String
    let message: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case reviewId = "review_id"
        case status
        case message
        case createdAt = "created_at"
    }
}

// MARK: - 후기 상세 조회 Response
struct ReviewDetailResponse: Codable {
    let reviewId: String
    let performanceTitle: String
    let artistName: String
    let performanceDate: String
    let performanceRound: String
    let venueName: String
    let venueAddress: String
    let seatZone: String
    let seatRow: String
    let seatNumber: String
    let seatRating: Int
    let simpleReview: String
    let performanceDetailReview: String?
    let sightImageUrls: [String]
    let performanceImageUrls: [String]
    let authorNickname: String
    let authorProfileImage: String?
    let likeCount: Int
    let commentCount: Int
    let scrapCount: Int
    let createdAt: String
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case reviewId = "review_id"
        case performanceTitle = "performance_title"
        case artistName = "artist_name"
        case performanceDate = "performance_date"
        case performanceRound = "performance_round"
        case venueName = "venue_name"
        case venueAddress = "venue_address"
        case seatZone = "seat_zone"
        case seatRow = "seat_row"
        case seatNumber = "seat_number"
        case seatRating = "seat_rating"
        case simpleReview = "simple_review"
        case performanceDetailReview = "performance_detail_review"
        case sightImageUrls = "sight_image_urls"
        case performanceImageUrls = "performance_image_urls"
        case authorNickname = "author_nickname"
        case authorProfileImage = "author_profile_image"
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case scrapCount = "scrap_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - 후기 목록 Response
struct ReviewListResponse: Codable {
    let reviews: [ReviewSummaryDTO]
    let currentPage: Int
    let totalPages: Int
    let totalItems: Int
    
    enum CodingKeys: String, CodingKey {
        case reviews
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case totalItems = "total_items"
    }
}

struct ReviewSummaryDTO: Codable {
    let reviewId: String
    let performanceTitle: String
    let artistName: String
    let venueName: String
    let seatInfo: String
    let rating: Int
    let simpleReview: String
    let thumbnailImageUrl: String?
    let authorNickname: String
    let likeCount: Int
    let commentCount: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case reviewId = "review_id"
        case performanceTitle = "performance_title"
        case artistName = "artist_name"
        case venueName = "venue_name"
        case seatInfo = "seat_info"
        case rating
        case simpleReview = "simple_review"
        case thumbnailImageUrl = "thumbnail_image_url"
        case authorNickname = "author_nickname"
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case createdAt = "created_at"
    }
}

// MARK: - 에러 Response
struct ErrorResponse: Codable {
    let error: String
    let message: String
    let code: Int
}
