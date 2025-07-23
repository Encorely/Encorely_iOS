//
//  SearchHistoryBtnType.swift
//  Encorely
//
//  Created by 이예지 on 7/12/25.
//

import Foundation

/// 검색기록 모델
struct SearchHistoryItem: Equatable, Codable {
    /// 검색기록 키워드
    let keyword: String
    
    /// 검색기록 일시
    let searchDate: String
}

