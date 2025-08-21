//
//  SearchVenueDTO.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import Foundation

/// 장소 검색 카드 Response
struct SearchVenueResponse: Codable, Identifiable {
    let name: String
    let address: String
    let image: String
    let id: Int
}
