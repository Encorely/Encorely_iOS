//
//  DIContainer.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import Foundation

/// 앱 전역에서 사용할 의존성 주입(Dependency Injection) 컨테이너 클래스
/// ViewModel, Router, UseCase 등 여러 공통 인스턴스를 중앙에서 주입하고 공유하기 위한 용도로 사용됨
class DIContainer: ObservableObject {
    
    /// 화면 전환을 제어하는 네비게이션 라우터
    @Published var navigationRouter = NavigationRouter()
    
    /// 후기 작성 데이터를 앱 전체에서 공유
    @Published var registViewModel = RegistViewModel()
    
    @Published var venueSelectionService: VenueSelectionServiceProtocol
    
    @Published var reviewService: ReviewService
    
    @Published var s3Service: S3Service
        
    /// 검색 전용 뷰모델
//    @Published var searchViewModel = SearchViewModel()
    
    /// DIContainer 초기화 함수
    /// 외부에서 navigationRouter와 useCaseService를 주입받아 사용할 수 있도록 구성
    /// 기본값으로는 각각 새로운 인스턴스를 생성하여 초기화
    init(
        navigationRouter: NavigationRouter = .init(),
        reviewService: ReviewService = .init(),
        s3Service: S3Service = .init(),
        venueSelectionService: VenueSelectionServiceProtocol = MockVenueSelectionService()
    ) {
        self.navigationRouter = navigationRouter
        self.reviewService = reviewService
        self.s3Service = s3Service
        self.venueSelectionService = venueSelectionService
    }
}
