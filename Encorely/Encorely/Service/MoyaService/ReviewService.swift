//
//  ReviewService.swift
//  Encorely
//
//  Created by 이예지 on 8/8/25.
//

import Foundation
import Moya

// MARK: Protocol
protocol ReviewServiceProtocol {
    func createReview(request: RegistReviewElement) async throws -> RegistReviewResponse
    func updateReview(reviewId: Int, request: RegistReviewElement) async throws -> UpdateReviewResponse
    func deleteReview(reviewId: Int) async throws -> DeleteReviewResponse
    func getReview(reviewId: Int) async throws -> RetrieveReviewResponse
    func deleteImage(imageId: Int) async throws -> DeleteReviewImageResponse
    func toggleLike(reviewId: Int) async throws -> LikeToggleResponse
    func hasLiked(reviewId: Int) async throws -> HasLikedResponse
    func addComment(reviewId: Int, request: AddCommentRequest) async throws -> AddCommentResponse
    func getComments(reviewId: Int) async throws -> GetCommentResponse
    func getReviewRanking() async throws -> ReviewRankingResponse
}

// MARK: ReviewService
@Observable
class ReviewService {
    
    private let provider: MoyaProvider<ReviewRouter>
        
        // 상태 관리
        var isLoading: Bool = false
        var errorMessage: String?
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<ReviewRouter>(plugins: [logger])
    }
    
    /// POST Method
    func createReview(request: RegistReviewElement) async throws -> RegistReviewResponse {
        isLoading = true
        defer { isLoading = false }
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.createReview(request: request)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodeData = try JSONDecoder().decode(RegistReviewResponse.self, from: response.data)
                        continuation.resume(returning: decodeData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// PUT Method
    func updateReview(reviewId: Int, request: RegistReviewElement) async throws -> UpdateReviewResponse {
        isLoading = true
        defer { isLoading = false }
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.updateReview(reviewId: reviewId, request: request)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(UpdateReviewResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    /// DELETE Method
    func deleteReview(reviewId: Int) async throws -> DeleteReviewResponse {
        isLoading = true
        defer { isLoading = false }
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.deleteReview(reviewId: reviewId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(DeleteReviewResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    /// GET Method
    func getReview(reviewId: Int) async throws -> RetrieveReviewResponse {
            isLoading = true
            defer { isLoading = false }
            
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(.getReview(reviewId: reviewId)) { result in
                    switch result {
                    case .success(let response):
                        do {
                            let decodedData = try JSONDecoder().decode(RetrieveReviewResponse.self, from: response.data)
                            continuation.resume(returning: decodedData)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    
    
    /// DELETE Method
    func deleteImage(imageId: Int) async throws -> DeleteReviewImageResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.deleteImage(imageId: imageId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(DeleteReviewImageResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    /// POST Method
    func toggleLike(reviewId: Int) async throws ->  LikeToggleResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.toggleLike(reviewId: reviewId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(LikeToggleResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// GET Method
    func hasLiked(reviewId: Int) async throws -> HasLikedResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.hasLiked(reviewId: reviewId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(HasLikedResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    /// POST Method
    func addComment(reviewId: Int, _ request: AddCommentRequest) async throws -> AddCommentResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.addComment(reviewId: reviewId, request: request)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(AddCommentResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    /// GET Method
    func getComments(reviewId: Int) async throws -> GetCommentResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getComments(reviewId: reviewId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(GetCommentResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    /// GET Method
    func getReviewRanking() async throws -> ReviewRankingResponse {

        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getReviewRanking) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(ReviewRankingResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: Error
extension ReviewService {
    /// 에러 메시지 초기화
    func clearError() {
        errorMessage = nil
    }
}
