//
//  SearchViewModel.swift
//  Encorely
//
//  Created by 이예지 on 8/18/25.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    
    enum SearchType {
        case venue
        case place
        
        var displayName: String {
            switch self {
            case .venue: return "공연장"
            case .place: return "맛집/편의시설"
            }
        }
    }
}
