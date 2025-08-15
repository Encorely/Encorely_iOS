//
//  AlarmDTOs.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

// 서버 데이터 예시용
struct AlarmDTO: Codable {
    let id: UUID
    let content: String
    let date: String
}

extension AlarmDTO {
    func toDomain() -> AlarmItem {
        AlarmItem(id: id, content: content, date: date)
    }
}
