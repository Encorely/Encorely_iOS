//
//  FacilityRouter.swift
//  Encorely
//
//  Created by 이민서 on 8/18/25.
//

import Foundation
import Moya

enum FacilityAPI {
    ///공연장별 편의시설 후기 목록 조회 API
    case facilities(hallId: Int, keyword: String, type: String, sort: String, page: Int, size: Int)
}

extension FacilityAPI: BaseTarget {
    var path: String {
        switch self {
        case .facilities:
            return "/api/facilities"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .facilities(hallId, keyword, type, sort, page, size):
            return .requestParameters(
                parameters: ["hallId": hallId,
                             "keyword": keyword,
                             "type": type,
                             "sort": sort,
                             "page": page,
                             "size": size],
                encoding: URLEncoding.queryString
            )
        }
    }
}
