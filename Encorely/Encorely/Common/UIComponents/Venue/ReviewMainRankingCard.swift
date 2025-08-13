//
//  ReviewMainRanking.swift
//  Encorely
//
//  Created by 이민서 on 8/13/25.
//

import SwiftUI
import Kingfisher

struct ReviewMainRankingCard: View {
    let reviewRanking: ReviewRanking
    
    var body: some View {
        Button(action: {
            //TODO: - 연결 추가
        }) {
            ZStack (alignment: .bottomLeading){
                backgroundUrlImage
                HStack {
                    profileUrlImage
                    userInfo
                }
                .padding()
            }
        }
    }
    
    //MARK: - 배경 리뷰 이미지
    @ViewBuilder
    private var backgroundUrlImage : some View {
        if let url = URL(string: reviewRanking.reviewImageURL) {
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
                .frame(width: 190, height: 275)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    //MARK: - 프로필 이미지
    @ViewBuilder
    private var profileUrlImage : some View {
        if let url = URL(string: reviewRanking.userProfileImageURL) {
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
                .frame(width: 29, height: 29)
                .clipShape(Circle())
        }
    }
    
    //MARK: - 유저 닉네임
    private var userInfo : some View {
        VStack{
            Text(reviewRanking.nickname)
                .font(.mainTextMedium14)
                .foregroundStyle(.grayColorJ)
        }
    }
}


#Preview {
    ReviewMainRankingCard(
        reviewRanking: ReviewRanking(
            id: 1,
            reviewImageURL: "https://media.nudge-community.com/8795197",
            userProfileImageURL: "https://i.namu.wiki/i/Z4-6cZ8HHTzCw61vJDzRll8TxVPGFJyRLb8kvX_n7UjWIKeuH7cqwZlFCWnSLUP-9_Iz-K31vhIOgaVZEqavKg.webp",
            nickname: "kpop_lovers",
            comment: nil
        )
    )
}
