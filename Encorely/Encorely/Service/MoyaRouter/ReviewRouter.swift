//
//  ReviewRouter.swift
//  Encorely
//
//  Created by 이예지 on 8/7/25.
//

import Foundation
import Moya

enum ReviewRouter {
    // 후기 등록
    case createReview(request: RegistReviewElement)
    
    // 후기 수정
    case updateReview(reviewId: Int, request: RegistReviewElement)
    
    // 후기 삭제
    case deleteReview(reviewId: Int)
    
    // 특정 후기 상세조회 (후기전문)
    case getReview(reviewId: Int)
    
    // 후기 등록/수정 중 특정 이미지 삭제
    case deleteImage(imageId: Int)
    
    // 좋아요/좋아요 취소
    case toggleLike(reviewId: Int)
    
    // 사용자가 특정 리뷰에 좋아요를 눌렀는지 확인
    case hasLiked(reviewId: Int)
    
    // 댓글 추가
    case addComment(reviewId: Int, request: AddCommentRequest)
    
    // 특정 후기의 댓글 목록 조회
    case getComments(reviewId: Int)
    
    // 화제의 후기들
    case getReviewRanking
}

extension ReviewRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://13.209.39.26:8080")!
    }
    
    var path: String {
        switch self {
        case .createReview:
            return "/api/reviews"
            
        case .updateReview(let reviewId, _):
            return "/api/reviews/\(reviewId)"
            
        case .deleteReview(let reviewId):
            return "/api/reviews/\(reviewId)"
            
        case .getReview(let reviewId):
            return "/api/reviews/\(reviewId)"
            
        case .deleteImage(let imageId):
            return "/api/reviews/images/\(imageId)"
            
        case .toggleLike(let reviewId):
            return "/api/reviews/\(reviewId)/like-toggle"
            
        case .hasLiked(let reviewId):
            return "/api/reviews/\(reviewId)/has-liked"
            
        case .addComment(let reviewId, _):
            return "/api/reviews/\(reviewId)/comments"
            
        case .getComments(let reviewId):
            return "/api/reviews/\(reviewId)/comments"
            
        case .getReviewRanking:
            return "/api/reviews/reviewRanking"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getReview, .hasLiked, .getComments, .getReviewRanking:
            return .get
            
        case .createReview, .toggleLike, .addComment:
            return .post
            
        case .updateReview:
            return .put
            
        case .deleteReview, .deleteImage:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getReview, .deleteReview, .deleteImage, .toggleLike, .hasLiked, .getComments, .getReviewRanking:
            return .requestPlain
            
        case .createReview(let request):
            return .requestJSONEncodable(request)
            
        case .updateReview(_, let request):
            return .requestJSONEncodable(request)
            
        case .addComment(_, let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .createReview, .updateReview:
            return [
                "Content-Type": "application/json", 
                "Accept": "application/json"
            ]
            
        case .addComment:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
            
        case .getReview, .deleteReview, .deleteImage, .toggleLike, .hasLiked, .getComments, .getReviewRanking:
            return [
                "Accept": "application/json"
            ]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
