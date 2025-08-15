//
//  TabCase.swift
//  Encorely
//
//  Created by 이예지 on 8/15/25.
//

import Foundation
import SwiftUI

enum TabCase: String, CaseIterable {
    // 메인 탭
    case venue = "공연 정보"
    
    // 후기 등록하기 탭
    case regist = "후기 등록"
    
    // 마이페이지 탭
    case mypage = "마이페이지"
    
    // 탭바 이미지
    var icon: Image {
        switch self {
        case .venue:
            return .init(.venueTab)
        case .regist:
            return .init(.registTab)
        case .mypage:
            return .init(.mypageTab)
        }
    }
}
