//
//  RegistViewModel.swift
//  Encorely
//
//  Created by 이예지 on 8/14/25.
//

import Foundation
import SwiftUI
import PhotosUI

// MARK: - 라벨 ↔ 코드 매핑 (백엔드 코드표에 맞춰 숫자 갱신 필요)
enum KeywordCodeMaps {
    // 좌석/후기 키워드(예시 값) → 서버 실제 코드로 교체하세요
    static let seat: [String: Int] = [
        "돌출이 가까워요": 1,
        "본무대가 가까워요": 2,
        "전광판이 잘 보여요": 3,
        "출입구가 가까워요": 4,
        "화장실이 가까워요": 5,
        "좌석 간격이 넓어요": 6,
        "짐 두기 편해요": 7,
        "가격 대비 시야가 괜찮아요": 8,
        "아티스트 표정까지 보여요": 9,
        "시야 방해가 없어요": 10,
        "토롯코랑 가까워요": 11,
        "오른쪽 블록이에요": 12,
        "왼쪽 블록이에요": 13,
        "정면 블록이에요": 14,
        "전광판이 잘 안 보여요": 101,
        "무대 돌출이 멀어요": 102,
        "본무대가 멀어요": 103,
        "무대 전체 구성이 안 보여요": 104,
        "객석 단차가 낮아요": 105,
        "스피커가 가까워서 귀가 아파요": 106,
        "좌석 간격이 좁아요": 107,
        "화장실이 멀어요": 108,
        "출구가 멀어요": 109,
        "좌석이 불편해요": 110,
        "가격 대비 시야가 별로예요": 111
    ]

    // 맛집 키워드(예시 값) → 서버 실제 코드로 교체하세요
    static let restaurant: [String: Int] = [
        "혼밥하기 편해요": 1,
        "공연장까지 거리가 가까워요": 2,
        "인테리어가 이뻐요": 3,
        "웨이팅이 짧았어요": 4,
        "가성비가 좋아요": 5,
        "음식이 빨리 나와요": 6,
        "가게가 넓어요": 7,
        "양이 많아요": 8,
        "늦게까지 해요": 9,
        "단체 방문 가능해요": 10
    ]
}

// 공용: 라벨 Set → Int 코드 배열(중복 제거, 정렬)
private func mapLabelsToCodes(_ labels: Set<String>, using map: [String:Int]) -> [Int] {
    Array(Set(labels.compactMap { map[$0] })).sorted()
}

// MARK: - 업로드 상태 구조체
struct ImageUploadStatus {
    let id = UUID()
    let originalImage: UIImage
    let fileName: String
    var presignedUrl: String?
    var s3Key: String?
    var uploadedUrl: String?
    var isUploading: Bool = false
    var uploadError: String?
    var isCompleted: Bool { uploadedUrl != nil }
}

// MARK: - ViewModel
class RegistViewModel: ObservableObject {
    
    // MARK: - Services
    private let reviewService = ReviewService()
    private let s3Service = S3Service()
    
    // MARK: - 공연 기본 정보
    @Published var selectedDate: Date? = nil
    @Published var showCalendar: Bool = false
    @Published var selectedRound: String = ""
    @Published var performanceTitle: String = ""
    @Published var artistName: String = ""
    
    // MARK: - 공연/시야 사진
    @Published var selectedImageCategory: ImageCategory = .sight
    @Published var currentPage: Int = 0
    @Published var performanceItems: [PhotosPickerItem] = []
    @Published var performanceImages: [UIImage] = []
    @Published var sightItems: [PhotosPickerItem] = []
    @Published var sightImages: [UIImage] = []
    
    // MARK: - 공연장 등록 관련
    @Published var venues: [SearchVenueResponse] = []
    @Published var searchVenue: String = ""
    @Published var selectedVenue: SearchVenueResponse? = nil

    // MARK: - 좌석 등록 관련
    @Published var zone: String = ""
    @Published var rows: String = ""
    @Published var num: String = ""
    
    // MARK: - 좌석 평가 관련
    @Published var rating: Int = 0
    @Published var selectedGoodKeywords: Set<String> = []   // 라벨 세트
    @Published var selectedBadKeywords: Set<String> = []    // 라벨 세트
    @Published var isCheckedSeat: Bool = false
    @Published var detailSeatReview: String = ""
    
    // MARK: - 공연 후기 관련
    @Published var isCheckedPerformance: Bool = false
    @Published var simplePerformanceReview: String = ""
    @Published var detailPerformanceReview: String = ""
    
    // MARK: - 맛집 및 편의시설 관련
    @Published var selectedRestaurantType: RestaurantType = .restaurant
    @Published var restaurantItem: PhotosPickerItem? = nil {
        didSet { if restaurantItem != nil { Task { await loadRestaurantImage() } } }
    }
    @Published var restaurantImage: UIImage? = nil
    @Published var selectedRestaurantKeywords: Set<String> = [] // 라벨 세트
    @Published var isCheckedRestaurant: Bool = false
    @Published var detailRestaurantReview: String = ""
    
    @Published var selectedFacilityType: FacilityType = .restroom
    @Published var facilityItem: PhotosPickerItem? = nil {
        didSet { if facilityItem != nil { Task { await loadFacilityImage() } } }
    }
    @Published var facilityImage: UIImage? = nil
    @Published var isCheckedFacility: Bool = false
    @Published var detailFacilityReview = ""
    
    @Published var searchPlace: String = ""
    
    // MARK: - S3 이미지 업로드 상태
    @Published var sightImageUploads: [ImageUploadStatus] = []
    @Published var performanceImageUploads: [ImageUploadStatus] = []
    @Published var isUploadingImages: Bool = false
    @Published var imageUploadError: String? = nil
    
    // MARK: - 시트 관리
    @Published var isShowingRatingSheet: Bool = false
    @Published var isShowingPFReviewSheet: Bool = false
    @Published var isShowingFacilitySheet: Bool = false
    
    func showRatingSheet() { isShowingRatingSheet = true }
    func showPFReviewSheet() { isShowingPFReviewSheet = true }
    func showFacilitySheet() { isShowingFacilitySheet = true }
    
    // MARK: - 업로드 상태
    @Published var isUploading: Bool = false
    @Published var uploadSuccess: Bool = false
    @Published var uploadError: String? = nil
    
    // MARK: 단계별 유효성
    var isVenueStepValid: Bool { selectedVenue != nil }
    var isRatingStepValid: Bool { rating > 0 }
    var isPerformanceStepValid: Bool { !simplePerformanceReview.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    
    private func isNonEmpty(_ s: String) -> Bool { !s.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    var isDateValid: Bool { selectedDate != nil }
    var isRoundValid: Bool { !selectedRound.isEmpty }
    var isTitleValid: Bool { isNonEmpty(performanceTitle) }
    var isArtistValid: Bool { isNonEmpty(artistName) }
    var isPhotoValid: Bool { !performanceImages.isEmpty || !performanceImageUploads.isEmpty }
    var isVenueSeatRatingValid: Bool {
        selectedVenue != nil && isNonEmpty(zone) && isNonEmpty(rows) && isNonEmpty(num) && rating > 0
    }
    var isReviewValid: Bool { isNonEmpty(simplePerformanceReview) }
    
    var isUploadEnabled: Bool {
        isDateValid && isRoundValid && isTitleValid && isArtistValid &&
        isPhotoValid && isVenueSeatRatingValid && isReviewValid
    }
    
    // MARK: - 공연 기본
    func selectDate(_ date: Date) { selectedDate = date; showCalendar = false }
    var displayDate: String {
        guard let date = selectedDate else { return "공연 일자" }
        let df = DateFormatter(); df.dateFormat = "yyyy.MM.dd"; return df.string(from: date)
    }
    func selectRound(_ round: String) { selectedRound = round }
    var displayRound: String { selectedRound.isEmpty ? "공연 회차" : selectedRound }
    
    // MARK: - 맛집/편의시설
    func selectRestaurant(_ type: RestaurantType) { selectedRestaurantType = type }
    var displayRestaurant: String { selectedRestaurantType.displayName }
    func selectFacility(_ type: FacilityType) { selectedFacilityType = type }
    var displayFacility: String { selectedFacilityType.displayName }
    
    // MARK: - 사진 로딩
    func selectedImageCategory(_ category: ImageCategory) { selectedImageCategory = category }
    var displayImageCategory: String { selectedImageCategory.displayName }
    
    @MainActor
    func loadSightImages() {
        Task {
            var images: [UIImage] = []
            var uploadStatuses: [ImageUploadStatus] = []
            for (index, item) in sightItems.enumerated() {
                if let imageData = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                    uploadStatuses.append(
                        ImageUploadStatus(
                            originalImage: uiImage,
                            fileName: "sight_\(Date().timeIntervalSince1970)_\(index).jpg"
                        )
                    )
                }
            }
            await MainActor.run {
                self.sightImages = images
                self.sightImageUploads = uploadStatuses
            }
        }
    }
    
    @MainActor
    func loadPerformanceImages() {
        Task {
            var images: [UIImage] = []
            var uploadStatuses: [ImageUploadStatus] = []
            for (index, item) in performanceItems.enumerated() {
                if let imageData = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                    uploadStatuses.append(
                        ImageUploadStatus(
                            originalImage: uiImage,
                            fileName: "performance_\(Date().timeIntervalSince1970)_\(index).jpg"
                        )
                    )
                }
            }
            await MainActor.run {
                self.performanceImages = images
                self.performanceImageUploads = uploadStatuses
            }
        }
    }
    
    @MainActor
    func loadRestaurantImage() {
        Task {
            guard let item = restaurantItem else { self.restaurantImage = nil; return }
            if let imageData = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: imageData) {
                self.restaurantImage = uiImage
            }
        }
    }
    
    @MainActor
    func loadFacilityImage() {
        Task {
            guard let item = facilityItem else { self.facilityImage = nil; return }
            if let imageData = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: imageData) {
                self.facilityImage = uiImage
            }
        }
    }
    
    // MARK: - 키워드 토글
    func toggleGoodKeyword(_ keyword: String) {
        if selectedGoodKeywords.contains(keyword) { selectedGoodKeywords.remove(keyword) }
        else { selectedGoodKeywords.insert(keyword) }
    }
    func toggleBadKeyword(_ keyword: String) {
        if selectedBadKeywords.contains(keyword) { selectedBadKeywords.remove(keyword) }
        else { selectedBadKeywords.insert(keyword) }
    }
    
    // MARK: - 이미지 업로드
    @MainActor
    func uploadAllImages() async {
        isUploadingImages = true
        imageUploadError = nil
        await uploadImageGroup(&sightImageUploads)
        await uploadImageGroup(&performanceImageUploads)
        let all = sightImageUploads + performanceImageUploads
        let failed = all.filter { $0.uploadError != nil }
        if !failed.isEmpty {
            imageUploadError = "\(failed.count)개 이미지 업로드에 실패했습니다"
            print("이미지 업로드 실패: \(failed.count)개")
        } else {
            print("모든 이미지 업로드 완료")
        }
        isUploadingImages = false
    }
    
    private func uploadImageGroup(_ uploadStatuses: inout [ImageUploadStatus]) async {
        for i in 0..<uploadStatuses.count { await uploadSingleImage(&uploadStatuses[i]) }
    }
    
    private func uploadSingleImage(_ uploadStatus: inout ImageUploadStatus) async {
        uploadStatus.isUploading = true
        do {
            guard let data = uploadStatus.originalImage.jpegData(compressionQuality: 0.8) else {
                throw NSError(domain: "ImageError", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지 데이터 변환 실패"])
            }
            let uploadedUrl = try await s3Service.uploadImage(data, fileName: uploadStatus.fileName)
            uploadStatus.uploadedUrl = uploadedUrl
            uploadStatus.isUploading = false
            uploadStatus.uploadError = nil
            print("이미지 업로드 성공: \(uploadStatus.fileName)")
        } catch {
            uploadStatus.isUploading = false
            uploadStatus.uploadError = error.localizedDescription
            print("이미지 업로드 실패: \(uploadStatus.fileName) - \(error)")
        }
    }
    
    // MARK: - 후기 등록
    var canUpload: Bool {
        !performanceTitle.isEmpty &&
        !artistName.isEmpty &&
        selectedDate != nil &&
        !selectedRound.isEmpty &&
        !isUploading &&
        !isUploadingImages
    }
    
    func submitReview() async {
        guard canUpload else {
            await MainActor.run { uploadError = "필수 정보를 모두 입력해주세요." }
            return
        }
        await MainActor.run {
            isUploading = true
            uploadError = nil
            uploadSuccess = false
        }
        do {
            // 1) 이미지 업로드
            await uploadAllImages()
            
            // 2) 업로드된 이미지 URL 수집 → ReviewImageInfo 조립
            let sightUrls = sightImageUploads.compactMap { $0.uploadedUrl }
            let performanceUrls = performanceImageUploads.compactMap { $0.uploadedUrl }
            var reviewImageInfos: [ReviewImageInfo] = []
            sightUrls.forEach { reviewImageInfos.append(.init(imageUrl: $0, imageType: "VIEW")) }
            performanceUrls.forEach { reviewImageInfos.append(.init(imageUrl: $0, imageType: "SHOW")) }
            
            // 3) 요청 생성
            let request = createRegistReviewRequest(reviewImageInfos: reviewImageInfos)
            
            // 디버깅: 실제 전송 JSON 확인
            if let data = try? JSONEncoder().encode(request),
               let json = String(data: data, encoding: .utf8) {
                print("🚀 createReview JSON:", json)
            }
            
            // 4) API 호출
            let response = try await reviewService.createReview(request: request)
            await MainActor.run {
                if response.isSuccess {
                    uploadSuccess = true
                    print("후기 등록 성공: \(response.message)")
                } else {
                    uploadError = response.message
                }
            }
        } catch {
            await MainActor.run { uploadError = error.localizedDescription }
            print("후기 등록 실패: \(error)")
        }
        await MainActor.run { isUploading = false }
    }
    
    // MARK: - Request 조립 (단일 반환, 라벨→코드 적용)
    private func createRegistReviewRequest(
        reviewImageInfos: [ReviewImageInfo]
    ) -> RegistReviewElement {
        
        // 날짜(yyyy-MM-dd)
        let df = DateFormatter(); df.dateFormat = "yyyy-MM-dd"
        let formattedDate = selectedDate.map { df.string(from: $0) } ?? ""
        
        // 회차 Int
        let roundInt = Int(selectedRound.replacingOccurrences(of: "회차", with: "")) ?? (Int(selectedRound) ?? 1)
        
        // 라벨 → 코드(Int 배열)
        let consAndProsCodes: [Int] =
            mapLabelsToCodes(selectedGoodKeywords, using: KeywordCodeMaps.seat)
          + mapLabelsToCodes(selectedBadKeywords,  using: KeywordCodeMaps.seat)
        
        let restaurantProsCodes: [Int] =
            mapLabelsToCodes(selectedRestaurantKeywords, using: KeywordCodeMaps.restaurant)
        
        // 현재 뷰모델에는 맛집/시설의 이름/주소/좌표 상태값이 없어서
        // 스키마 오류를 피하기 위해 빈 배열로 보냄(추후 상태값 추가되면 채워서 전송)
        let restaurantInfos: [RestaurantInfo] = []  // isCheckedRestaurant ? [...] : []
        let facilityInfos: [FacilityInfo] = []      // isCheckedFacility ? [...] : []
        
        return RegistReviewElement(
            showDate: formattedDate,
            round: roundInt,
            showName: performanceTitle,
            artistName: artistName,
            hallId: selectedVenue?.id ?? 0,
            seatArea: zone,
            seatRow: rows,
            seatNumber: num,
            rating: rating,
            consAndProsList: consAndProsCodes,        // ✅ [Int]
            seatDetail: isCheckedSeat ? detailSeatReview : "",
            comment: simplePerformanceReview,
            showDetail: isCheckedPerformance ? detailPerformanceReview : "",
            reviewImageInfos: reviewImageInfos,       // ✅ "VIEW"/"SHOW"
            restaurantInfos: restaurantInfos,         // 나중에 상태값 추가되면 채우기
            facilityInfos: facilityInfos              // 나중에 상태값 추가되면 채우기
        )
    }
    
    // MARK: - 전체 초기화
    func resetAll() {
        selectedDate = nil
        selectedRound = ""
        performanceTitle = ""
        artistName = ""
        
        performanceImages.removeAll()
        sightImages.removeAll()
        performanceItems.removeAll()
        sightItems.removeAll()
        performanceImageUploads.removeAll()
        sightImageUploads.removeAll()
        currentPage = 0
        selectedImageCategory = .sight
        
        searchVenue = ""
        selectedVenue = nil
        
        zone = ""
        rows = ""
        num = ""
        
        rating = 0
        selectedGoodKeywords.removeAll()
        selectedBadKeywords.removeAll()
        isCheckedSeat = false
        detailSeatReview = ""
        
        simplePerformanceReview = ""
        isCheckedPerformance = false
        detailPerformanceReview = ""
        
        selectedRestaurantType = .restaurant
        restaurantImage = nil
        restaurantItem = nil
        selectedRestaurantKeywords.removeAll()
        isCheckedRestaurant = false
        detailRestaurantReview = ""
        selectedFacilityType = .restroom
        facilityImage = nil
        facilityItem = nil
        isCheckedFacility = false
        detailFacilityReview = ""
        
        isUploading = false
        uploadSuccess = false
        uploadError = nil
        isUploadingImages = false
        imageUploadError = nil
    }
    
    // MARK: - 진행률/상태
    var totalUploadProgress: Double {
        if isUploadingImages {
            let total = sightImageUploads.count + performanceImageUploads.count
            let completed = sightImageUploads.filter { $0.isCompleted }.count +
                            performanceImageUploads.filter { $0.isCompleted }.count
            return total > 0 ? Double(completed) / Double(total) * 0.8 : 0.0
        } else if isUploading {
            return 0.9
        } else { return 0.0 }
    }
    
    var statusMessage: String {
        if isUploadingImages { return "이미지 업로드 중..." }
        else if isUploading { return "후기 등록 중..." }
        else if uploadSuccess { return "후기 등록 완료!" }
        else { return "" }
    }
}

extension RegistViewModel {
    @MainActor
    func fetchAllVenues(using service: VenueSelectionServiceProtocol) async {
        do {
            let result = try await service.getAllVenues()
            self.venues = result
            print("공연장 불러오기 성공: \(result.count)개")
        } catch {
            print("공연장 불러오기 실패: \(error)")
        }
    }
}
