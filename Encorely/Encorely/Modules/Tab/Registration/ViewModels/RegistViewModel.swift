//
//  RegistViewModel.swift
//  Encorely
//
//  Created by 이예지 on 8/14/25.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImageUploadStatus {
    let id = UUID()
    let originalImage: UIImage
    let fileName: String
    var presignedUrl: String?
    var s3Key: String?
    var uploadedUrl: String?
    var isUploading: Bool = false
    var uploadError: String?
    var isCompleted: Bool {
        uploadedUrl != nil
    }
}

class RegistViewModel: ObservableObject {
    
    // MARK: - Services
    private let reviewService = ReviewService()
    private let s3Service = S3Service()
    
    // MARK: - 공연 기본 정보
    /// 날짜 선택
    @Published var selectedDate: Date? = nil
    /// 달력 표시 여부
    @Published var showCalendar: Bool = false
    /// 회차 선택
    @Published var selectedRound: String = ""
    /// 공연명 TextField
    @Published var performanceTitle: String = ""
    /// 아티스트명 TextField
    @Published var artistName: String = ""
    
    
    // MARK: - 공연/시야 사진
    /// 사진 카테고리
    @Published var selectedImageCategory: ImageCategory = .sight
    /// 사진 페이지 컨트롤 페이지 인덱스
    @Published var currentPage: Int = 0
    /// 공연 사진
    @Published var performanceItems: [PhotosPickerItem] = []
    @Published var performanceImages: [UIImage] = []
    /// 시야 사진
    @Published var sightItems: [PhotosPickerItem] = []
    @Published var sightImages: [UIImage] = []
    
    
    // MARK: - 공연장 등록 관련
    /// 공연장 리스트
    @Published var venues: [SearchVenueResponse] = []
    /// 검색창 textField
    @Published var searchVenue: String = ""
    /// 공연장 선택
    @Published var selectedVenue: SearchVenueResponse? = nil

    
    // MARK: - 좌석 등록 관련
    /// 구역
    @Published var zone: String = ""
    /// 열
    @Published var rows: String = ""
    /// 번
    @Published var num: String = ""
    
    
    // MARK: - 좌석 평가 관련
    /// 별점
    @Published var rating: Int = 0
    /// 좌석 키워드 평가
    @Published var selectedGoodKeywords: Set<String> = []
    @Published var selectedBadKeywords: Set<String> = []
    /// 좌석에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedSeat: Bool = false
    /// 좌석에 대한 자세한 후기 작성 TextEditor
    @Published var detailSeatReview: String = ""
    
    
    // MARK: - 공연 후기 관련
    /// 공연에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedPerformance: Bool = false
    /// 공연에 대한 한줄평 TextEditor
    @Published var simplePerformanceReview: String = ""
    /// 공연에 대한 자세한 후기 작성 TextEditor
    @Published var detailPerformanceReview: String = ""
    
    
    // MARK: - 맛집 및 편의시설 관련
    
    // 맛집
    /// 맛집 카테고리 선택
    @Published var selectedRestaurantType: RestaurantType = .restaurant
    /// 맛집 사진 고르기
    @Published var restaurantItem: PhotosPickerItem? = nil {
        didSet {
            if restaurantItem != nil {
                Task {
                    await loadRestaurantImage()
                }
            }
        }
    }
    /// 맛집 사진 담기
    @Published var restaurantImage: UIImage? = nil
    /// 맛집에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedRestaurant: Bool = false
    
    /// 맛집에 대한 자세한 후기 작성 TextEditor
    @Published var detailRestaurantReview: String = ""
    
    // 편의시설
    /// 편의시설 카테고리선택
    @Published var selectedFacilityType: FacilityType = .restroom
    /// 편의시설 사진 고르기
    @Published var facilityItem: PhotosPickerItem? = nil {
        didSet {
            if facilityItem != nil {
                Task {
                    await loadFacilityImage()
                }
            }
        }
    }
    /// 편의시설 사진 담기
    @Published var facilityImage: UIImage? = nil
    /// 편의시설에 대해 더 자세한 후기를 남길래요
    @Published var isCheckedFacility: Bool = false
    /// 편의시설에 대한 자세한 후기 작성 TextEditor
    @Published var detailFacilityReview = ""
    
    // 맛집 및 편의시설 검색
    @Published var searchPlace: String = ""
    
    
    // MARK: - S3 이미지 업로드 상태 관리
    @Published var sightImageUploads: [ImageUploadStatus] = []
    @Published var performanceImageUploads: [ImageUploadStatus] = []
    @Published var isUploadingImages: Bool = false
    @Published var imageUploadError: String? = nil
    
    // MARK: - 시트 관리
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
    
    
    // MARK: - 업로드 상태 관리
    @Published var isUploading: Bool = false
    @Published var uploadSuccess: Bool = false
    @Published var uploadError: String? = nil
    
    
    // MARK: 업로드 버튼 활성화/비활성화
    /// 공연장 등록
    var isVenueStepValid: Bool {
            selectedVenue != nil
    }
    
    /// 좌석 등록
    
    
    
    /// 좌석 평가
    var isRatingStepValid: Bool {
        return rating > 0
    }
    
    /// 공연 후기
    
    
    
    /// 맛집 및 편의시설
    
    
    
    /// 전체 리뷰 등록
    
    // MARK: - 공연 기본 정보 관련 함수들
    /// 공연일자 받기
    func selectDate(_ date: Date) {
        selectedDate = date
        showCalendar = false
    }
    
    /// 날짜 선택 유무
    var isDateSelected: Bool {
        selectedDate != nil
    }
    
    /// 공연일자 드롭다운 버튼 표시
    var displayDate: String {
        guard let date = selectedDate else {
            return "공연 일자"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    /// 공연회차 받기
    func selectRound(_ round: String) {
        selectedRound = round
    }
    
    /// 공연회차 드롭다운 버튼 표시
    var displayRound: String {
        selectedRound.isEmpty ? "공연 회차" : selectedRound
    }
    
    
    // MARK: - 맛집 및 편의시설 관련 함수들
    /// 맛집 카테고리 받기
    func selectRestaurant(_ type: RestaurantType) {
        selectedRestaurantType = type
    }
    
    /// 맛집 카테고리 드롭다운 버튼 표시
    var displayRestaurant: String {
        selectedRestaurantType.displayName
    }
    /// 편의시설 카테고리 받기
    func selectFacility(_ type: FacilityType) {
        selectedFacilityType = type
    }
    
    /// 편의시설 카테고리 드롭다운 버튼 표시
    var displayFacility: String {
        selectedFacilityType.displayName
    }
    
    
    // MARK: - 사진 관련 함수들
    /// 사진 카테고리 받기
    func selectedImageCategory(_ category: ImageCategory) {
        selectedImageCategory = category
    }
    
    /// 사진 카테고리 드롭다운 버튼 표시
    var displayImageCategory: String {
        selectedImageCategory.displayName
    }
    
    /// 시야사진 PhotosPickerItem을 UIImage로 변환
    @MainActor
    func loadSightImages() {
        Task {
            var images: [UIImage] = []
            var uploadStatuses: [ImageUploadStatus] = []
            
            for (index, item) in sightItems.enumerated() {
                if let imageData = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                    
                    // 업로드 상태 객체 생성
                    let uploadStatus = ImageUploadStatus(
                        originalImage: uiImage,
                        fileName: "sight_\(Date().timeIntervalSince1970)_\(index).jpg"
                    )
                    uploadStatuses.append(uploadStatus)
                }
            }
            
            await MainActor.run {
                self.sightImages = images
                self.sightImageUploads = uploadStatuses
            }
        }
    }
    
    /// 공연사진 PhotosPickerItem을 UIImage로 변환
    @MainActor
    func loadPerformanceImages() {
        Task {
            var images: [UIImage] = []
            var uploadStatuses: [ImageUploadStatus] = []
            
            for (index, item) in performanceItems.enumerated() {
                if let imageData = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                    
                    // 업로드 상태 객체 생성
                    let uploadStatus = ImageUploadStatus(
                        originalImage: uiImage,
                        fileName: "performance_\(Date().timeIntervalSince1970)_\(index).jpg"
                    )
                    uploadStatuses.append(uploadStatus)
                }
            }
            
            await MainActor.run {
                self.performanceImages = images
                self.performanceImageUploads = uploadStatuses
            }
        }
    }
    
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
    
    // MARK: - 공연장 관련 함수들
    
    
    
    // MARK: - 키워드 관련 함수들
    func toggleGoodKeyword(_ keyword: String) {
        if selectedGoodKeywords.contains(keyword) {
            selectedGoodKeywords.remove(keyword)
        } else {
            selectedGoodKeywords.insert(keyword)
        }
    }
    
    func toggleBadKeyword(_ keyword: String) {
        if selectedBadKeywords.contains(keyword) {
            selectedBadKeywords.remove(keyword)
        } else {
            selectedBadKeywords.insert(keyword)
        }
    }
    
    
    // MARK: - 이미지 업로드 기능
    /// 모든 이미지를 S3에 업로드
    @MainActor
    func uploadAllImages() async {
        isUploadingImages = true
        imageUploadError = nil
        
        await uploadImageGroup(&sightImageUploads, imageType: "sight")
        await uploadImageGroup(&performanceImageUploads, imageType: "performance")
        
        // 에러 체크
        let allUploads = sightImageUploads + performanceImageUploads
        let failedUploads = allUploads.filter { $0.uploadError != nil }
        
        if !failedUploads.isEmpty {
            imageUploadError = "\(failedUploads.count)개 이미지 업로드에 실패했습니다"
            print("❌ 이미지 업로드 실패: \(failedUploads.count)개")
        } else {
            print("✅ 모든 이미지 업로드 완료!")
        }
        
        isUploadingImages = false
    }
    
    /// 이미지 그룹 업로드 (시야 또는 공연)
    private func uploadImageGroup(_ uploadStatuses: inout [ImageUploadStatus], imageType: String) async {
        for i in 0..<uploadStatuses.count {
            await uploadSingleImage(&uploadStatuses[i])
        }
    }
    
    /// 개별 이미지 업로드
    private func uploadSingleImage(_ uploadStatus: inout ImageUploadStatus) async {
        uploadStatus.isUploading = true
        
        do {
            guard let imageData = uploadStatus.originalImage.jpegData(compressionQuality: 0.8) else {
                throw NSError(domain: "ImageError", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지 데이터 변환 실패"])
            }
            
            // S3Service를 통한 업로드
            let uploadedUrl = try await s3Service.uploadImage(imageData, fileName: uploadStatus.fileName)
            
            uploadStatus.uploadedUrl = uploadedUrl
            uploadStatus.isUploading = false
            uploadStatus.uploadError = nil
            
            print("✅ 이미지 업로드 성공: \(uploadStatus.fileName)")
            
        } catch {
            uploadStatus.isUploading = false
            uploadStatus.uploadError = error.localizedDescription
            
            print("❌ 이미지 업로드 실패: \(uploadStatus.fileName) - \(error)")
        }
    }
    
    // MARK: - 후기 등록 (실제 API 호출)
    
    /// 업로드 가능 여부 검증
    var canUpload: Bool {
        return !performanceTitle.isEmpty &&
        !artistName.isEmpty &&
        selectedDate != nil &&
        !selectedRound.isEmpty &&
        !isUploading &&
        !isUploadingImages
    }
    
    /// 실제 후기 업로드 (이미지 업로드 + 후기 등록)
    func submitReview() async {  // ⚠️ 파라미터 제거
        // 입력값 검증
        guard canUpload else {
            await MainActor.run {
                uploadError = "필수 정보를 모두 입력해주세요."
            }
            return
        }
        
        await MainActor.run {
            isUploading = true
            uploadError = nil
            uploadSuccess = false
        }
        
        do {
            // 1. 이미지 업로드
            await uploadAllImages()
            
            // 2. 업로드된 이미지 URL 수집
            let sightUrls = sightImageUploads.compactMap { $0.uploadedUrl }
            let performanceUrls = performanceImageUploads.compactMap { $0.uploadedUrl }
            
            // 3. ReviewImageInfo 생성
            var reviewImageInfos: [ReviewImageInfo] = []
            
            sightUrls.forEach { url in
                reviewImageInfos.append(ReviewImageInfo(imageUrl: url, imageType: "sight"))
            }
            
            performanceUrls.forEach { url in
                reviewImageInfos.append(ReviewImageInfo(imageUrl: url, imageType: "performance"))
            }
            
            // 4. API 요청 생성
            let request = createRegistReviewRequest(
                reviewImageInfos: reviewImageInfos
            )
            
            // 5. 후기 등록 API 호출
            let response = try await reviewService.createReview(request: request)
            
            await MainActor.run {
                if response.isSuccess {
                    uploadSuccess = true
                    print("✅ 후기 등록 성공: \(response.message)")
                } else {
                    uploadError = response.message
                }
            }
            
        } catch {
            await MainActor.run {
                uploadError = error.localizedDescription
            }
            print("❌ 후기 등록 실패: \(error)")
        }
        
        await MainActor.run {
            isUploading = false
        }
    }
        
        /// RegistReviewRequest 생성  ⚠️ 함수명 및 파라미터 수정
        private func createRegistReviewRequest(
            reviewImageInfos: [ReviewImageInfo]
        ) -> RegistReviewElement {  // ⚠️ 반환 타입 수정
            
            // 날짜 포맷팅 (API 형식에 맞게)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = selectedDate.map { formatter.string(from: $0) } ?? ""
            
            // 회차를 Int로 변환
            let roundInt = Int(selectedRound.replacingOccurrences(of: "회차", with: "")) ?? 1
            
            // 키워드 합치기
            let allKeywords = (Array(selectedGoodKeywords) + Array(selectedBadKeywords)).joined(separator: ",")
            
            return RegistReviewElement(  // ⚠️ 올바른 타입 사용
                showDate: formattedDate,
                round: roundInt,
                showName: performanceTitle,
                artistName: artistName,
                hallId: selectedVenue?.id ?? 1, // ⚠️ 안전한 처리
                seatArea: zone,
                seatRow: rows,
                seatNumber: num,
                seatRating: rating,
                consAndProsList: allKeywords,
                seatDetail: isCheckedSeat ? detailSeatReview : nil,
                comment: simplePerformanceReview,
                showDetail: isCheckedPerformance ? detailPerformanceReview : nil,
                reviewImageInfos: reviewImageInfos,
                restaurantInfos: createRestaurantInfos(),
                facilityInfos: createFacilityInfos()
            )
        }
    
    /// RestaurantInfo 생성 (통합된 함수)
        private func createRestaurantInfos() -> [RestaurantInfo]? {
            guard isCheckedRestaurant else { return nil }
            
            return [RestaurantInfo(
                restaurantType: selectedRestaurantType.rawValue,
                name: "맛집 이름", // TODO: 실제 맛집 이름
                address: "맛집 주소", // TODO: 실제 맛집 주소
                latitude: "37.5665", // TODO: 실제 위도
                longitude: "126.9780", // TODO: 실제 경도
                restaurantDetail: detailRestaurantReview,
                imageUrl: "", // TODO: 맛집 이미지 URL
                restaurantProsList: "" // TODO: 맛집 키워드
            )]
        }
        
        /// FacilityInfo 생성 (통합된 함수)
    private func createFacilityInfos() -> [FacilityInfo]? {
        guard isCheckedFacility else { return nil }
        
        return [FacilityInfo(
            facilityType: selectedFacilityType.rawValue,
            name: "편의시설 이름", // TODO: 실제 편의시설 이름
            address: "편의시설 주소", // TODO: 실제 편의시설 주소
            latitude: "37.5665", // TODO: 실제 위도
            longitude: "126.9780", // TODO: 실제 경도
            tips: detailFacilityReview,
            imageUrl: "" // TODO: 편의시설 이미지 URL
        )]
    }
        
    // MARK: - 진행률 및 상태
    
    /// 전체 업로드 진행률
    var totalUploadProgress: Double {
        if isUploadingImages {
            let totalImages = sightImageUploads.count + performanceImageUploads.count
            let completedImages = sightImageUploads.filter { $0.isCompleted }.count +
                                performanceImageUploads.filter { $0.isCompleted }.count
            
            return totalImages > 0 ? Double(completedImages) / Double(totalImages) * 0.8 : 0.0
        } else if isUploading {
            return 0.9 // 이미지 업로드 완료, 후기 등록 중
        } else {
            return 0.0
        }
    }
    
    /// 현재 상태 메시지
    var statusMessage: String {
        if isUploadingImages {
            return "이미지 업로드 중..."
        } else if isUploading {
            return "후기 등록 중..."
        } else if uploadSuccess {
            return "후기 등록 완료!"
        } else {
            return ""
        }
    }
}

extension RegistViewModel {
    @MainActor
    func fetchAllVenues(using service: VenueSelectionServiceProtocol) async {
        do {
            let result = try await service.getAllVenues()
            self.venues = result
            print("✅ 공연장 불러오기 성공: \(result.count)개")
        } catch {
            print("❌ 공연장 불러오기 실패: \(error)")
        }
    }
}
