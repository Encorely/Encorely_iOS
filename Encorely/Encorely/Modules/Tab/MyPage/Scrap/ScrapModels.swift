//
//  ScrapModels.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

// Modules/Scrap/ScrapModels.swift
import Foundation

struct ScrapItem: Identifiable, Equatable {
    let id: UUID
    let userName: String
    let seatText: String
    let scrapCount: Int
    let rating: Int          // 1~5
    let imageNames: [String] // 카드에 보여줄 썸네일들
    let summary: String
    let tags: [String]
}

struct ScrapFolder: Identifiable, Equatable {
    let id: UUID
    var name: String
    var coverImageName: String
    var items: [ScrapItem]
}
