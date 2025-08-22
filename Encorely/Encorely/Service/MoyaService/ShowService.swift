//
//  ShowService.swift
//  Encorely
//
//  Created by 이민서 on 8/22/25.
//

import Foundation
import Moya

@Observable
class ShowService {
    private let provider: MoyaProvider<ShowAPI>
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<ShowAPI>(plugins: [logger])
    }
    
    // MARK: - 현재 진행 중인 공연 불러오기 (GET Method)
    func fetchShows() async throws -> [ShowItem] {
        isLoading = true
        defer { isLoading = false }   ///끝나면 false
        errorMessage = nil
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.shows) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(ShowResponse.self, from: response.data)
                        continuation.resume(returning: decoded.result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // MARK: - 공연 상세 정보 불러오기 (GET Method)
    func fetchShowDetail(showId: Int) async throws -> ShowDetailItem {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.showsDetail(showId: showId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(ShowDetailResponse.self, from: response.data)
                        continuation.resume(returning: decoded.result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // MARK: - 현재 진행 중인 공연 검색 (GET Method)
    func searchShows(keyword: String) async throws -> [ShowItem] {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.showsSearch(searchKeyword: keyword)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode([ShowItem].self, from: response.data)
                        continuation.resume(returning: decoded)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // MARK: - 에러 초기화
    func clearError() {
        errorMessage = nil
    }
}
