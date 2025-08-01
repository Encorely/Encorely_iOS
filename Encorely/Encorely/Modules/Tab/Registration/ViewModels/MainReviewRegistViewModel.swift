//
//  MainReviewRegistViewModel.swift
//  Encorely
//
//  Created by 이예지 on 7/22/25.
//

import Foundation
import SwiftUI

class MainReviewRegistViewModel: ObservableObject {
    
    // MARK: 공연 일자
    /// 날짜 선택
    @Published var selectedDate: Date? = nil
    /// 달력 표시 여부
    @Published var showCalendar: Bool = false
  
    
    /// 날짜 받기
    func selectDate(_ date: Date) {
        selectedDate = date
        showCalendar = false
    }
    
    /// 날짜 선택 유무
    var isDateSelected: Bool {
        selectedDate != nil
    }
    
    /// 드롭다운 버튼 표시
    var displayDate: String {
        guard let date = selectedDate else {
            return "공연 일자"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    // MARK: 공연 회차
    /// 회차 선택
    @Published var selectedRound: String = ""
    
    /// menu action
    func selectRound(_ round: String) {
        selectedRound = round
    }
    
    /// 드롭다운 버튼 표시
    var displayRound: String {
        selectedRound.isEmpty ? "공연 회차" : selectedRound
    }
    
    
    // MARK: 공연명, 아티스트명
    /// 공연명 TextField
    @Published var performanceTitle: String = ""
    
    /// 아티스트명 TextField
    @Published var artistName: String = ""
    
    
    // MARK: 사진
    /// 공연 사진
    @Published var performanceImage: Image?
    
    /// 시야 사진
    @Published var sightImage: Image?
    
    /// 사진 카테고리
    @Published var selectedImageCategory: String = "시야사진"
    
    /// menu action
    func selectedImageCategory(_ category: String) {
        selectedImageCategory = category
    }
    
    /// 드롭다운 버튼 표시
    var displayImageCategory: String {
        selectedImageCategory.isEmpty ? "시야사진" : selectedImageCategory
    }
    
    /// 사진 업로드
    @Published var uploadedImage: [Image] = []
    
    /// 페이지 컨트롤 페이지 인덱스
    @Published var currentPage: Int = 0
    
    
    
    
    // MARK: 리뷰 작성 이동 버튼
    /// 공연장/좌석 등록/평가 sheet
    @Published var isShowingRatingSheet: Bool = false
    
    /// 공연 후기 sheet
    @Published var isShowingPFReviewSheet: Bool = false
    
    /// 맛집/편의시설
    @Published var isShowingFacilitySheet: Bool = false
    
    
    
    
    /// 버튼 클릭 시 sheet 표시
    func showRatingSheet() {
        isShowingRatingSheet = true
    }
    
    func showPFReviewSheet() {
        isShowingPFReviewSheet = true
    }
    
    func showFacilitySheet() {
        isShowingFacilitySheet = true
    }
    
    
    func mainRegistBtnTapped() {
        //upload
    }
    
//    private var isAllRequiredFieldsFilled: Bool {
//        
//    }
}
