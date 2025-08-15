//
//  S3Router.swift
//  Encorely
//
//  Created by 이예지 on 8/7/25.
//

import Foundation
import Moya

enum S3Router {
    // 이미지 업로드를 위한 presigned-url
    case getPresignedURL(fileName: String, contentType: String)
    
    // 이미지 업로드 완료 알림
    case uploadComplete(key: String)
}

extension S3Router: TargetType {
    
    var baseURL: URL {
        return URL(string:
        "http://13.209.39.26:8080")!
    }
    
    var path: String {
        switch self {
        case .getPresignedURL:
            return "/api/s3/presigned-url"
            
        case .uploadComplete:
            return "/api/s3/upload-complete"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPresignedURL:
            return .get
            
        case .uploadComplete:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getPresignedURL(let fileName, let contentType):
            return .requestParameters(
            parameters:
                ["fileName": fileName,
                "contentType": contentType],
                encoding: URLEncoding.queryString
            )
            
        case .uploadComplete(let key):
            return .requestParameters(
                parameters:
                    ["key": key],
                encoding: JSONEncoding.default
                )
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getPresignedURL:
            return [
                "Accept": "application/json"
            ]
            
        case .uploadComplete:
            return [
                "Content-Type": "application",
                "Accept": "application/json"
            ]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
