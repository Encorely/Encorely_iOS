//
//  DIContainer.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import Foundation

final class DIContainer: ObservableObject {
    static let shared = DIContainer()

    @Published var navigationRouter: NavigationRouter
    @Published var registViewModel: RegistViewModel

    @Published var venueSelectionService: VenueSelectionServiceProtocol
    @Published var reviewService: ReviewService
    @Published var s3Service: S3Service

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

        self.registViewModel = RegistViewModel()
    }

    // 프리뷰용
    static let preview = DIContainer()
}
