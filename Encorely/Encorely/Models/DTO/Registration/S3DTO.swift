//
//  S3DTO.swift
//  Encorely
//
//  Created by 이예지 on 8/8/25.
//

import Foundation
import SwiftUI

// MARK: 이미지 업로드를 위한 presigned-url GET
/// 이미지 업로드 response
typealias PresignedUrlResponse = APIResponse<PresignedUrlResult>

struct PresignedUrlResult: Codable {
    let url: String
    let key: String
}


// MARK: 이미지 업로드 완료 알림
/// 이미지 업로드 완료 알림 response
typealias UploadCompleteResponse = APIResponse<AlarmResult>

struct AlarmResult: Codable {
    let imageId: Int
    let imageUrl: String
    let createdAt: String
}
