//
//  RegistDomainModel.swift
//  Encorely
//
//  Created by 이예지 on 8/4/25.
//

import Foundation
import SwiftUI

// MARK: - 공연 정보
struct Performance {
    let date: Date?
    let round: String
    let title: String
    let artistName: String
    
    var isValid: Bool {
        return date != nil &&
            !round.isEmpty &&
            !title.isEmpty &&
            !artistName.isEmpty
    }
}

// MARK: - 사진 정보


// MARK: - 공연장 정보
// SearchVenueDTO.swift

// MARK: - 좌석 정보
struct SeatInfo {
    let zone: String
    let rows: String
    let num: String
    
    var displayText: String {
        "\(zone)구역 \(rows)열 \(num)번"
    }
    
    var isEmpty: Bool {
        !zone.isEmpty && !rows.isEmpty && !num.isEmpty
    }
}

// MARK: - 좌석 평가
struct SeatRating {
    let rating: Int
    let goodKeywords: [String]
    let badKeywords: [String]
    let detailReview: String?
    
    var isValid: Bool {
        rating > 0
    }
}

// MARK: - 공연 후기
struct performanceReview {
    let simpleReview: String
    let detailReview: String?
    
    var isValid: Bool {
        !simpleReview.isEmpty
    }
}
