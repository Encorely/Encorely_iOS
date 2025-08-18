//
//  HallRouter.swift
//  Encorely
//
//  Created by 이민서 on 8/18/25.
//

import Foundation
import Moya

enum HallAPI {
    ///공연장 리스트
    case halls(page: Int, size: Int, sort: String)
    
    ///공연장 검색
    case hallsSearch(searchKeyword: String)
    
    ///인기 있는 공연장 상위 6개
    case hallsRanking
}

extension HallAPI: BaseTarget {
    var path: String {
        switch self {
        case .halls:
            return "/api/halls"
        case .hallsSearch:
            return "/api/halls/search"
        case .hallsRanking:
            return "/api/halls/ranking"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .halls(page, size, sort):
            return .requestParameters(
                parameters: ["page": page, "size": size, "sort": sort],
                encoding: URLEncoding.default
            )
        case let .hallsSearch(searchKeyword):
            return .requestParameters(
                parameters: ["searchKeyword": searchKeyword],
                encoding: URLEncoding.default
            )
        case .hallsRanking:
            return .requestPlain
            
        }
    }
}
