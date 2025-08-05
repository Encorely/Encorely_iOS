//
//  MainRegistType.swift
//  Encorely
//
//  Created by 이예지 on 8/4/25.
//

import Foundation
import SwiftUI

// MARK: - 사진 카테고리
enum ImageCategory: String, CaseIterable {
    case sight = "시야사진"
    case performance = "공연사진"

    var displayName: String { rawValue }
}

// MARK: - 맛집 유형
enum RestaurantType: String, CaseIterable {
    case restaurant = "밥집"
    case cafe = "카페"
    case bar = "술집"

    var displayName: String { rawValue }
}

// MARK: - 편의시설 유형
enum FacilityType: String, CaseIterable {
    case restroom = "화장실"
    case convenienceStore = "편의점"
    case parking = "주차장"
    case bench = "벤치"
    case atm = "ATM"
    case other = "기타"

    var displayName: String { rawValue }
}
