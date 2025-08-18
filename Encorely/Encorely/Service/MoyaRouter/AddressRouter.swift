//
//  AddressRouter.swift
//  Encorely
//
//  Created by 이민서 on 8/18/25.
//

import Foundation
import Moya

enum AddressAPI {
    ///주소 검색 API
    case addresses(keyword: String, page: Int, size: Int)
}

extension AddressAPI: BaseTarget {
    var path: String {
        switch self {
        case .addresses:
            return "/api/addresses"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .addresses(keyword, page, size):
            return .requestParameters(
                parameters: ["keyword": keyword,
                             "page": page,
                             "size": size],
                encoding: URLEncoding.queryString
            )
        }
    }
}
