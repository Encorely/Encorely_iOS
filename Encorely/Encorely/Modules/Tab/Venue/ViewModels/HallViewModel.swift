//
//  HallViewModel.swift
//  Encorely
//
//  Created by 이민서 on 8/23/25.
//

import Foundation

@Observable
class HallViewModel {
    private let service: HallService
    
    /// 공연장 리스트
    var halls: [HallRanking] = []
    /// 검색 결과
    var searchResults: [HallRanking] = []
    /// 인기 있는 공연장 상위 6개
    var hallRanking: [HallRanking] = []
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(service: HallService = HallService()) {
        self.service = service
    }
    
    // MARK: - 공연장 리스트 불러오기
    func loadHalls(page: Int = 0, size: Int = 20, sort: String = "ranking") async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let dtoList = try await service.fetchHalls(page: page, size: size, sort: sort) /// [HallRankingItem]
            self.halls = dtoList.map { HallRanking(dto: $0) }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - 공연장 검색
    func search(keyword: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let dtoList = try await service.searchHalls(keyword: keyword) /// [HallRankingItem]
            self.searchResults = dtoList.map { HallRanking(dto: $0) }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - 인기 공연장 상위 6개
    func loadHallRanking() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let dtoList = try await service.fetchHallRanking() /// [HallRankingItem]
            self.hallRanking = dtoList.map { HallRanking(dto: $0) }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - 에러 초기화
    func clearError() {
        errorMessage = nil
    }
}
