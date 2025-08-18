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
        switch task {
        case .requestJSONEncodable, .requestParameters:
            return ["Content-Type": "application/json"]
        case .uploadMultipart:
            return ["Content-Type": "multipart/form-data"]
        default:
            return nil
        }
    }
}
