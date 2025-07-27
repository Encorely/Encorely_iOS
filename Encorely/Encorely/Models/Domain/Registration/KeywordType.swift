//
//  KeywordType.swift
//  Encorely
//
//  Created by 이예지 on 7/24/25.
//

import Foundation

struct KeywordType: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

extension KeywordType {
    static let goodSeatTag: [KeywordType] = [
        KeywordType(title: "돌출이 가까워요"),
        KeywordType(title: "본무대가 가까워요"),
        KeywordType(title: "전광판이 잘 보여요"),
        KeywordType(title: "출입구가 가까워요"),
        KeywordType(title: "화장실이 가까워요"),
        KeywordType(title: "좌석 간격이 넓어요"),
        KeywordType(title: "짐 두기 편해요"),
        KeywordType(title: "가격 대비 시야가 괜찮아요"),
        KeywordType(title: "아티스트 표정까지 보여요"),
        KeywordType(title: "시야 방해가 없어요"),
        KeywordType(title: "토롯코랑 가까워요"),
        KeywordType(title: "오른쪽 블록이에요"),
        KeywordType(title: "왼쪽 블록이에요"),
        KeywordType(title: "정면 블록이에요")
    ]
    
    static let badSeatTag: [KeywordType] = [
        KeywordType(title: "전광판이 잘 안 보여요"),
        KeywordType(title: "무대 돌출이 멀어요"),
        KeywordType(title: "본무대가 멀어요"),
        KeywordType(title: "무대 전체 구성이 안 보여요"),
        KeywordType(title: "객석 단차가 낮아요"),
        KeywordType(title: "스피커가 가까워서 귀가 아파요"),
        KeywordType(title: "좌석 간격이 좁아요"),
        KeywordType(title: "화장실이 멀어요"),
        KeywordType(title: "출구가 멀어요"),
        KeywordType(title: "좌석이 불편해요"),
        KeywordType(title: "가격 대비 시야가 별로예요"),
        KeywordType(title: "본무대가 멀어요")
    ]
    
    static let RestaurantTag: [KeywordType] = [
        KeywordType(title: "혼밥하기 편해요"),
        KeywordType(title: "공연장까지 거리가 가까워요"),
        KeywordType(title: "인테리어가 이뻐요"),
        KeywordType(title: "웨이팅이 짧았어요"),
        KeywordType(title: "가성비가 좋아요"),
        KeywordType(title: "음식이 빨리 나와요"),
        KeywordType(title: "가게가 넓어요"),
        KeywordType(title: "양이 많아요"),
        KeywordType(title: "늦게까지 해요"),
        KeywordType(title: "단체 방문 가능해요")
    ]
}
