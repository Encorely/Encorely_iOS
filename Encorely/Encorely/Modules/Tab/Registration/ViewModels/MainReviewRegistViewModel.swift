//
//  MainReviewRegistViewModel.swift
//  Encorely
//
//  Created by 이예지 on 7/22/25.
//

import Foundation
import SwiftUI
import PhotosUI

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
    @Published var performanceItems: [PhotosPickerItem] = []
    @Published var performanceImages: [UIImage] = []
    
    /// 시야 사진
    @Published var sightItems: [PhotosPickerItem] = []
    @Published var sightImages: [UIImage] = []
    
    /// 사진 카테고리
    @Published var selectedImageCategory: ImageCategory = .sight
    
    /// menu action
    func selectedImageCategory(_ category: ImageCategory) {
        selectedImageCategory = category
    }
    
    /// 드롭다운 버튼 표시
    var displayImageCategory: String {
        selectedImageCategory.displayName
    }
    
    
    /// 페이지 컨트롤 페이지 인덱스
    @Published var currentPage: Int = 0
    
    // MARK: PhotosPicker 처리 함수들
    /// 시야사진 PhotosPickerItem을 UIImage로 변환
    @MainActor
    func loadSightImages() {
        Task {
            var images: [UIImage] = []
            
            for item in sightItems {
                if let imageData = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                }
            }
            
            await MainActor.run {
                self.sightImages = images
            }
        }
    }
    
    /// 공연사진 PhotosPickerItem을 UIImage로 변환
    @MainActor
    func loadPerformanceImages() {
        Task {
            var images: [UIImage] = []
            
            for item in performanceItems {
                if let imageData = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                }
            }
            
            await MainActor.run {
                self.performanceImages = images
            }
        }
    }
    
    
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
    
    // 업로드 상태 관리
    @Published var isUploading: Bool = false
    @Published var uploadSuccess: Bool = false
    @Published var uploadError: String? = nil
    
    // MARK: 업로드
    /// 업로드 가능 여부 검증
    var canUpload: Bool {
        return !performanceTitle.isEmpty &&
        !artistName.isEmpty &&
        selectedDate != nil &&
        !selectedRound.isEmpty
    }
    
    /// 업로드 시뮬레이션
    func submitReview(subViewModel: SubRegistViewModel) {
        // 입력값 검증
        guard canUpload else {
            uploadError = "필수 정보를 모두 입력해주세요."
            return
        }
        
        // 로딩 상태 시작
        isUploading = true
        uploadError = nil
        uploadSuccess = false
        
        // Mock API 호출 시뮬레이션 (2초 대기)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            // 개발 중에는 항상 성공
            self?.handleUploadSuccess()
        }
    }
        
        // 🆕 추가: 성공 처리
        private func handleUploadSuccess() {              // ← 새로 추가!
            isUploading = false
            uploadSuccess = true
            uploadError = nil
            print("✅ 후기 업로드 성공! (시뮬레이션)")
        }
        
        // 🆕 추가: 실패 처리
        private func handleUploadFailure(_ errorMessage: String) {  // ← 새로 추가!
            isUploading = false
            uploadSuccess = false
            uploadError = errorMessage
            print("❌ 후기 업로드 실패: \(errorMessage)")
        }
        
    
}
