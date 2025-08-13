//
//  VenueSelectionService.swift
//  Encorely
//
//  Created by 이예지 on 7/21/25.
//

import Foundation
import Moya

protocol VenueSelectionServiceProtocol {
    func getAllVenues() async throws -> [SearchVenueResponse]
    func searchVenue(query: String) async throws -> [SearchVenueResponse]
}

class MockVenueSelectionService: VenueSelectionServiceProtocol {
    private let mockVenues: [SearchVenueResponse] = [
        SearchVenueResponse(
            name: "고척 스카이돔",
            address: "서울특별시 구로구 경인로 430",
            image: "https://media.timeout.com/images/102941553/750/422/image.jpg"
        ),
        SearchVenueResponse(
            name: "KSPO DOME",
            address: "서울특별시 송파구 올림픽로 424",
            image: "https://i.namu.wiki/i/_fXUcU47B6_6KSMYUANfdEMzm5I6Y_z-66KKCoBknhNJQcyKZkDSb5B1nwIxegZYOx10c7Xb6EUFcghvs0R8Aw.webp"
            ),
        SearchVenueResponse(
            name: "장충체육관",
            address: "서울특별시 중구 동호로 241",
            image: "https://www.sisul.or.kr/open_content/jangchung/images/intro.jpg"
        ),
        SearchVenueResponse(
            name: "서울월드컵경기장",
            address: "서울특별시 마포구 월드컵로 240",
            image: "https://i.namu.wiki/i/weOyvjMO4Pv2TzZPXdlaTj3zzbQglcDeBUPrVf9WADE8899wqRWrl1WYknSDDr7BC-lk2WzTdWfBKvDAKChUew.webp"
        ),
        SearchVenueResponse(
            name: "잠실실내체육관",
            address: "서울특별시 송파구 올림픽로 25",
            image: "https://i.namu.wiki/i/80J-s6xQiEM_iI5g9As481C8PKg5RhtsUeSFlYv6GjjWmD2vqtPPvRLSrDbchW7jyszmNR4eZ-zoV9aIwdZDCQ.webp"
        ),
        SearchVenueResponse(
            name: "인스파이어 아레나",
            address: "인천광역시 중구 영종해안남로 321",
            image: "https://cdn.incheonilbo.com/news/photo/202408/1260533_573197_5059.jpg"
        ),
        SearchVenueResponse(
            name: "고양종합운동장 주경기장",
            address: "경기도 고양시 일산서구 중앙로 160",
            image: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Goyang_sta_1.JPG/330px-Goyang_sta_1.JPG"
        )
    ]
    
    func getAllVenues() async throws -> [SearchVenueResponse] {
        return mockVenues
    }
    
    func searchVenue(query: String) async throws -> [SearchVenueResponse] {
        return mockVenues.filter { venue in
            return venue.name.contains(query) || venue.address.contains(query)
        }
    }
}
