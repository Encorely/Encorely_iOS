//
//  ShowDTO.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import Foundation

//MARK: - response 래퍼
struct ShowResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [ShowItem]
}

//MARK: - response item
struct ShowItem: Decodable {
    let showId: Int
    let imageUrl: String
    let showName: String
    let hallId: Int
    let hallName: String
    let startDate: String
    let endDate: String
}

//MARK: - 내부 모델
struct OngoingShow: Identifiable, Equatable {
    
    let id: Int
    let imageUrl: String
    let showName: String
    let hallId: Int?
    let hallName: String
    let startDate: String
    let endDate: String
}

extension OngoingShow {
    init(dto: ShowItem) {
        self.id = dto.showId
        self.imageUrl = dto.imageUrl
        self.showName = dto.showName
        self.hallId = dto.hallId
        self.hallName = dto.hallName
        self.startDate = dto.startDate
        self.endDate = dto.endDate
    }
}
