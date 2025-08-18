//
//  RestaurantRouter.swift
//  Encorely
//
//  Created by 이민서 on 8/18/25.
//

import Foundation
import Moya

enum RestaurantAPI {
    ///공연장별 맛집 후기 목록 조회 API
    case restaurants(hallId: Int, keyword: String, type: String, sort: String, page: Int, size: Int)
}

extension RestaurantAPI: BaseTarget {
    var path: String {
        switch self {
        case .restaurants:
            return "/api/restaurants"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .restaurants(hallId, keyword, type, sort, page, size):
            return .requestParameters(
                parameters: ["hallId": hallId,
                             "keyword": keyword,
                             "type": type,
                             "sort": sort,
                             "page": page,
                             "size": size],
                encoding: URLEncoding.queryString)
        }
    }
}
    

