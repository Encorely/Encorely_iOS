//
//  LikeDTO.swift
//  Encorely
//
//  Created by 이예지 on 8/8/25.
//

import Foundation

// MARK: 좋아요/좋아요 취소
/// 좋아요/좋아요 취소 response
typealias LikeToggleResponse = APIResponse<LikeResult>


// MARK: 좋아요 조회
/// 좋아요 조회 response
typealias HasLikedResponse = APIResponse<LikeResult>


// MARK: LikeResult
struct LikeResult: Codable {
    let additionalProp1: Bool
    let additionalProp2: Bool
    let additionalProp3: Bool
}
