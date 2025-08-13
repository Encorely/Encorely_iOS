//
//  SubRegistViewModel.swift
//  Encorely
//
//  Created by 이예지 on 7/22/25.
//

import Foundation
import SwiftUI
import PhotosUI

class SubRegistViewModel: ObservableObject {
    
    // MARK: RegistVenueViewModel
    /// 공연장 리스트
    @Published var venues: [SearchVenueResponse] = []
    
    /// 검색창 textField
    @Published var searchVenue: String = ""
    
    /// 공연장 선택
    @Published var selectedVenue: SearchVenueResponse? = nil
    
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
    
    /// 좌석 키워드 평가
    @Published var selectedGoodKeywords: Set<String> = []
    @Published var selectedBadKeywords: Set<String> = []
    
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
    @Published var selectedRestaurantType: RestaurantType = .restaurant
    
    /// menu action
    func selectRestaurant(_ type: RestaurantType) {
        selectedRestaurantType = type
    }
    
    /// 드롭다운 버튼 표시
    var displayRestaurant: String {
        selectedRestaurantType.displayName
    }
    
    /// 맛집 사진
    @Published var restaurantItem: PhotosPickerItem? = nil {
        didSet {
            if restaurantItem != nil {
                Task {
                    await loadRestaurantImage()
                }
            }
        }
    }
    
    @Published var restaurantImage: UIImage? = nil
    
    /// 맛집 사진 PhotosPickerItem을 UIImage로 변환
    @MainActor
    func loadRestaurantImage() {
        Task {
            guard let item = restaurantItem else {
                self.restaurantImage = nil
                return
            }
            
            if let imageData = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: imageData) {
                self.restaurantImage = uiImage
            }
        }
    }
    
    /// 맛집에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedRestaurant: Bool = false
    
    /// 맛집에 대한 자세한 후기 작성 TextEditor
    @Published var detailRestaurantReview: String = ""
    
    // 편의시설 드롭다운
    /// 편의시설 선택
    @Published var selectedFacilityType: FacilityType = .restroom
    
    /// menu action
    func selectFacility(_ type: FacilityType) {
        selectedFacilityType = type
    }
    
    /// 드롭다운 버튼 표시
    var displayFacility: String {
        selectedFacilityType.displayName
    }
    
    /// 편의시설 사진
    @Published var facilityItem: PhotosPickerItem? = nil {
        didSet {
            if facilityItem != nil {
                Task {
                    await loadFacilityImage()
                }
            }
        }
    }
    
    @Published var facilityImage: UIImage? = nil
    
    /// 맛집 사진 PhotosPickerItem을 UIImage로 변환
    @MainActor
    func loadFacilityImage() {
        Task {
            guard let item = facilityItem else {
                self.facilityImage = nil
                return
            }
            
            if let imageData = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: imageData) {
                self.facilityImage = uiImage
            }
        }
    }
    
    /// 편의시설에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedFacility: Bool = false
        
    /// 편의시설에 대한 자세한 후기 작성 TextEditor
    @Published var detailFacilityReview = ""
    
    
    
    @Published var searchPlace: String = ""
        
    func toggleGoodKeyword(_ keyword: String) {
        if selectedGoodKeywords.contains(keyword) {
            selectedGoodKeywords.remove(keyword)
        } else {
            selectedGoodKeywords.insert(keyword)
        }
    }
        
}

