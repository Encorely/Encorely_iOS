//
//  VenueCard.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI
import Kingfisher

/// 공연장 탭 - 공연장 검색 리스트
struct MainVenueCard: View {

    let searchVenueResponse: SearchVenueResponse
    
    var body: some View {
        HStack(spacing: 20) {
            urlImage
            venueInfo
            Spacer()
            venueDetailBtn
        }
    }
    
    // MARK: 공연장 정보(이름, 주소)
    private var venueInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(searchVenueResponse.name)
                .font(.mainTextMedium18)
                .foregroundStyle(.grayScaleA)
            
            Text(searchVenueResponse.address)
                .font(.mainTextMedium14)
                .foregroundStyle(.grayScaleH)
        }
    }
    
    // MARK: 공연장 자세히 보기 이동 버튼
    private var venueDetailBtn: some View {
        Button(action: {
        // TODO: 공연장 이동
        }) {
            Image(.chevronRight)
                .resizable()
                .foregroundStyle(.grayScaleA)
                .frame(width: 24, height: 24)
        }
    }
    
    // MARK: 이미지 가져오기
    @ViewBuilder
    private var urlImage: some View {
        if let url = URL(string: searchVenueResponse.image) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .controlSize(.regular)
                }.retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
        }
    }
    
    
}

#Preview(traits: .sizeThatFitsLayout) {
    MainVenueCard(searchVenueResponse: .init(name: "KSPO DOME", address: "서울특별시 송파구 올림픽로 424", image: "https://i.namu.wiki/i/F4tCq3s3vS8MTOl1j1E6kPpiKu6lL9iLr6jl5OeSPLln1fBem4R8uHT0Mn7DuEqyCb5_xWrSwRROxviJDEGPIfhkLR3uV1zWfYyPISIXbou6vMoLPLkzdz1YgNmjqpgY8PG7cJxBwfl5jcHbEUJehQ.webp"))
}
