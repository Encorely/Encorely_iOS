//
//  SubRegistViewModel.swift
//  Encorely
//
//  Created by 이예지 on 7/22/25.
//

import Foundation
import SwiftUI

class SubRegistViewModel: ObservableObject {
    
    // MARK: 맛집 드롭다운
    /// 맛집 선택
    @Published var selectedRestaurant: String = ""
    
    /// menu action
    func selectRestaurant(_ restaurant: String) {
        selectedRestaurant = restaurant
    }
    
    /// 드롭다운 버튼 표시
    var displayRestaurant: String {
        selectedRestaurant.isEmpty ? "밥집" : selectedRestaurant
    }
    
    // MARK: 편의시설 드롭다운
    /// 편의시설 선택
    @Published var selectedFacility: String = ""
    
    /// menu action
    func selectFacility(_ facility: String) {
        selectedFacility = facility
    }
    
    /// 드롭다운 버튼 표시
    var displayFacility: String {
        selectedFacility.isEmpty ? "화장실" : selectedFacility
    }
}
