//
//  HallCircleCard.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI
import Kingfisher

struct HallCircleCard: View {
    let hallCircleCardType: HallCircleCardType
    
    var body: some View {
        
        Button(action: {
            //TODO: - 연결 추가
        }) {
            VStack {
                urlImage
                Spacer() .frame(height:10)
                placeInfo
            }
        }
    }
    
    @ViewBuilder
    private var urlImage : some View {
        if let url = URL(string: hallCircleCardType.imageURL) {
            KFImage(url)
                .placeholder({
                    ProgressView()
                        .controlSize(.mini)
                }).retry(maxCount: 2, interval: .seconds(2))
                .onFailure { error in
                    print("이미지 로드 실패: \(error)")
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 82)
                .clipShape(Circle())
        }
    }
        
    private var placeInfo : some View {
        VStack{
            Text(hallCircleCardType.name)
                .font(.mainTextMedium16)
                .foregroundStyle(.grayColorA)
            
            Spacer() .frame(height:7)
            
            Label(hallCircleCardType.address, image: .location)
                .font(.mainTextMedium14)
                .foregroundStyle(.grayColorF)
        }
    }
}

#Preview {
    HallCircleCard(
        hallCircleCardType: HallCircleCardType(
                id : UUID(),
                name : "고척 스카이돔",
                address : "구로구",
                imageURL : "https://media.timeout.com/images/102941553/750/422/image.jpg"
            )
        )
}
