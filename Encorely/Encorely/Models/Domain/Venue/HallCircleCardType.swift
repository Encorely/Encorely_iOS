//
//  HallCircleCardType.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//
import Foundation

struct HallCircleCardType: Codable, Identifiable {
    let id: UUID
    let name: String
    let address: String
    let imageURL: String
}
