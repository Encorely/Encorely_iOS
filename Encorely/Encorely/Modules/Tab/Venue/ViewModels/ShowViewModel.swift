//
//  ShowViewModel.swift
//  Encorely
//
//  Created by 이민서 on 8/22/25.
//

import Foundation


@Observable
class ShowViewModel {
    private let service: ShowService
    
    /// 현재 진행 중인 공연 리스트
    var shows: [OngoingShow] = []
    /// 각 공연 상세 정보,, 딕셔너리로 저장
    var selectedShows: [Int: OngoingShowDetail] = [:]
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(service: ShowService = ShowService()) {
        self.service = service
    }
    
    // MARK: - 공연 리스트 불러오기
    func loadShows() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let dtoList = try await service.fetchShows()   /// [ShowItem]
            print("서버 응답 성공: \(dtoList)")
            self.shows = dtoList.map { OngoingShow(dto: $0) }
            print("변환 후 shows: \(self.shows)")
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - 공연 상세 불러오기
    func loadShowDetail(showId: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        /// 이미 불러왔으면 또 요청 안 해도 되게?
        if selectedShows[showId] != nil { return }
        
        do {
            let dtoList = try await service.fetchShowDetail(showId: showId) /// ShowDetailItem
            self.selectedShows[showId] = OngoingShowDetail(dto: dtoList)
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - 공연 검색
    func search(keyword: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let dtoList = try await service.searchShows(keyword: keyword)  /// [ShowItem]
            self.shows = dtoList.map { OngoingShow(dto: $0) }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - 에러 초기화
    func clearError() {
        errorMessage = nil
    }
}

