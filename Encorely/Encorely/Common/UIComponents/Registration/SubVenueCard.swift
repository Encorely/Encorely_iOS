//
//  VenueRegist.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI
import Kingfisher

/// 후기작성창 - 공연장 등록
struct SubVenueCard: View {
    
    let searchVenueResponse: SearchVenueResponse
    @State private var isSelectedVenue: Bool = false
    
    var body: some View {
        Button (action: {
            isSelectedVenue.toggle()
        }) {
            HStack(spacing: 20) {
                urlImage
                venueInfo
                Spacer()
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 7)
            .border(.mainColorA, width: isSelectedVenue ? 1 : 0)
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

#Preview {
    SubVenueCard(searchVenueResponse: .init(name: "KSPO DOME", address: "서울특별시 송파구 올림픽로 424", image: "https://i.namu.wiki/i/F4tCq3s3vS8MTOl1j1E6kPpiKu6lL9iLr6jl5OeSPLln1fBem4R8uHT0Mn7DuEqyCb5_xWrSwRROxviJDEGPIfhkLR3uV1zWfYyPISIXbou6vMoLPLkzdz1YgNmjqpgY8PG7cJxBwfl5jcHbEUJehQ.webp"))
}
