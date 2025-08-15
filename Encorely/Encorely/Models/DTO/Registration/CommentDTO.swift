//
//  CommentDTO.swift
//  Encorely
//
//  Created by 이예지 on 8/8/25.
//

import Foundation

// MARK: 댓글 추가
/// 댓글 추가 request
struct AddCommentRequest: Codable {
    let content: String
    let parentId: Int?
}

/// 댓글 추가 response
typealias AddCommentResponse = APIResponse<String>


// MARK: 댓글 목록 조회
/// 댓글 목록 조회 response
typealias GetCommentResponse = APIResponse<CommentItem>

struct CommentItem: Codable {
    let id: Int
    let content: String
    let userNickname: String
    let timeAgo: String
    let children: [String]
    let mine: Bool
}
