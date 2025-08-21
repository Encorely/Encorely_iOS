//
//  ShowRouter.swift
//  Encorely
//
//  Created by 이민서 on 8/18/25.
//

import Foundation
import Moya

enum ShowAPI {
    ///현재 진행 중인 공연
    case shows
    
    ///공연 상세 정보 불러오기
    case showsDetail(showId: Int)
    
    ///현재 진행 중인 공연 검색
    case showsSearch(searchKeyword: String)
    
}

extension ShowAPI: BaseTarget {
    var path: String {
        switch self {
        case .shows:
            return "/api/shows"
        case let .showsDetail(showId):
            return "/api/shows/\(showId)"
        case .showsSearch(_):
            return "/api/shows/ongoing/search"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .shows, .showsDetail:
            return .requestPlain
        case let .showsSearch(searchKeyword):
            return .requestParameters(
                parameters: ["searchKeyword": searchKeyword],
                encoding: URLEncoding.default
            )
        }
    }
}
