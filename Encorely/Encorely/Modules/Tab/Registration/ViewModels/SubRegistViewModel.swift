//
//  SubRegistViewModel.swift
//  Encorely
//
//  Created by 이예지 on 7/22/25.
//

import Foundation
import SwiftUI

class SubRegistViewModel: ObservableObject {
    
    // MARK: RegistVenueViewModel
    /// 공연장 리스트
    @Published var venues: [SearchVenueResponse] = []
    
    /// 검색창 textField
    @Published var text: String = ""
    
    // MARK: RegistSeatViewModel
    /// 구역
    @Published var zone: String = ""
    
    /// 열
    @Published var rows: String = ""
    
    /// 번
    @Published var num: String = ""
    
    
    // MARK: RegistRateViewModel
    /// 별점
    @Published var rating: Int = 0
    
    /// 좌석에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedSeat: Bool = false
    
    /// 좌석에 대한 자세한 후기 작성 TextEditor
    @Published var detailSeatReview: String = ""
    
    // MARK: RegistPerformanceReviewView
    /// 공연에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedPerformance: Bool = false
    
    /// 공연에 대한 한줄평 TextEditor
    @Published var simplePerformanceReview: String = ""
    
    /// 공연에 대한 자세한 후기 작성 TextEditor
    @Published var detailPerformanceReview: String = ""
    
    
    // MARK: RegistFacilityViewModel
    // 맛집
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
    
    /// 맛집에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedRestaurant: Bool = false
    
    /// 맛집에 대한 자세한 후기 작성 TextEditor
    @Published var detailRestaurantReview: String = ""
    
    /// 맛집 장소 링크 TextField
    @Published var restaurantURL: URL?
    
    
    // 편의시설 드롭다운
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
    
    /// 편의시설에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedFacility: Bool = false
    
    /// 편의시설에 대한 자세한 후기 작성 TextEditor
    @Published var detailFacilityReview = ""
    
    /// 편의시설 장소 링크 TextField
    @Published var facilityURL: URL?
    
}
