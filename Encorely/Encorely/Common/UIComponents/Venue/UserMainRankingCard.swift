//
//  UserMainRankingCard.swift
//  Encorely
//
//  Created by 이민서 on 8/13/25.
//

import SwiftUI
import Kingfisher

struct UserMainRankingCard: View {
    let userRanking: UserRanking
    
    var body: some View {
        Button(action: {
            //TODO: - 연결 추가
        }) {
            ZStack{
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white)
                    .frame(width:153, height: 230)
                    .shadow(color: Color(red: 0.29, green: 0.29, blue: 0.29).opacity(0.3), radius: 4, x: 0, y: 2)
                
                VStack {
                    urlImage
                    Spacer() .frame(height:30)
                    performerInfo
                }
            }
            .padding(4)
        }
    }
    
    //MARK: - 프로필 이미지
    @ViewBuilder
    private var urlImage : some View {
        if let url = URL(string: userRanking.imageUrl) {
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
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        }
    }
   
    //MARK: - 닉네임 + 한 줄 소개
    private var performerInfo : some View {
        VStack {
            Text(userRanking.nickname)
                .font(.mainTextMedium16)
                .foregroundStyle(.grayColorA)
            
            Spacer() .frame(height:10)
            
            Text(userRanking.instruction)
                .font(.mainTextMedium14)
                .foregroundStyle(.grayColorF)
        }
    }
}

#Preview {
    UserMainRankingCard(
        userRanking: UserRanking(
            id: 1,
            nickname: "회원 아이디",
            imageUrl: "https://www.hidomin.com/news/photo/202408/555650_315040_3204.jpg",
            instruction: "JPOP을 좋아하는 사람"
        )
    )
}
