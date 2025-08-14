//
//  HallDTO.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import Foundation

//MARK: - request
struct HallRankingRequest: Encodable {
    let page: Int
    let size: Int
    let sort: [String]
}

//MARK: - response 래퍼
struct HallRankingResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: HallRankingResult
}

//MARK: - result
struct HallRankingResult: Decodable {
    let hallRankingList: [HallRankingItem]
}

//MARK: - response item
struct HallRankingItem: Decodable {
    let name: String
    let hallImageUrl: String
    let address: String
    let ranking: Int
}

//MARK: - 내부 모델
struct HallRanking: Identifiable, Equatable {
    let id: Int            // = ranking (고유한 순위값 사용)
    let name: String
    let hallImageURL: String
    let address: String
    let ranking: Int
}

extension HallRanking {
    init(dto: HallRankingItem) {
        self.id = dto.ranking
        self.name = dto.name
        self.hallImageURL = dto.hallImageUrl
        self.address = dto.address
        self.ranking = dto.ranking
    }
}
