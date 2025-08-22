//
//  HallService.swift
//  Encorely
//
//  Created by 이민서 on 8/23/25.
//

import Foundation
import Moya

@Observable
class HallService {
    private let provider: MoyaProvider<HallAPI>
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<HallAPI>(plugins: [logger])
    }
    
    // MARK: - 공연장 리스트 불러오기 (GET Method)
    func fetchHalls(page: Int, size: Int, sort: String) async throws -> [HallRankingItem] {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.halls(page: page, size: size, sort: sort)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(HallRankingResponse.self, from: response.data)
                        continuation.resume(returning: decoded.result.hallRankingList)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // MARK: - 공연장 검색 (GET Method)
    func searchHalls(keyword: String) async throws -> [HallRankingItem] {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.hallsSearch(searchKeyword: keyword)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(HallRankingResponse.self, from: response.data)
                        continuation.resume(returning: decoded.result.hallRankingList)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // MARK: - 인기 공연장 상위 6개 (GET Method)
    func fetchHallRanking() async throws -> [HallRankingItem] {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.hallsRanking) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(HallRankingResponse.self, from: response.data)
                        continuation.resume(returning: decoded.result.hallRankingList)
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
