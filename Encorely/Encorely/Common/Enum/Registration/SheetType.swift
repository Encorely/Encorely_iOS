//
//  SheetType.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import Foundation

enum SheetType: Identifiable {
    case calendar
    case venueSeatRating
    case performanceReview
    case facility
    
    var id: Int {
        hashValue
    }
}
