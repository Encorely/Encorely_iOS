//
//  ShowDetailDTO.swift
//  Encorely
//
//  Created by 이민서 on 8/15/25.
//

import Foundation


//MARK: - response 래퍼
struct ShowDetailResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ShowDetailItem
}

//MARK: - response item
struct ShowDetailItem: Decodable {
    let imageUrl: String
    let showName: String
    let hallId: Int
    let hallName: String
    let startDate: String
    let endDate: String
    let age: Int
    let link: String
}

//MARK: - 내부 모델
struct OngoingShowDetail: Identifiable, Equatable {
    let imageUrl: String
    let showName: String
    let id: Int
    let hallName: String
    let startDate: String
    let endDate: String
    let age: Int
    let link: String?
}

extension OngoingShowDetail {
    init(dto: ShowDetailItem) {
        self.imageUrl = dto.imageUrl
        self.showName = dto.showName
        self.id = dto.hallId
        self.hallName = dto.hallName
        self.startDate = dto.startDate
        self.endDate = dto.endDate
        self.age = dto.age
        self.link = dto.link
    }
}
