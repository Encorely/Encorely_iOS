//
//  BaseTarget.swift
//  Encorely
//
//  Created by 이민서 on 8/18/25.
//

import Foundation
import Moya

protocol BaseTarget: TargetType {}

extension BaseTarget {
    var baseURL: URL {
        return URL(string: "http://13.209.39.26:8080")!
    }
}

extension BaseTarget {
    var headers: [String : String]? {
        // 1) 기본 헤더 (요청 타입에 따라 Content-Type 설정)
        var result: [String: String] = {
            switch task {
            case .requestJSONEncodable, .requestParameters:
                return ["Content-Type": "application/json"]
            case .uploadMultipart:
                return ["Content-Type": "multipart/form-data"]
            default:
                return [:]
            }
        }()

        // 2) 저장된 accessToken이 있으면 Authorization 추가
        if let token = TokenStore.shared.load()?.access, !token.isEmpty {
            result["Authorization"] = "Bearer \(token)"
        }

        // (선택) Accept-Language 등 추가하고 싶으면 여기서
        // result["Accept-Language"] = "ko-KR"

        return result.isEmpty ? nil : result
    }
}
