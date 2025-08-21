//
//  ReviewFacilityCard.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import SwiftUI
import Kingfisher

struct ReviewFacilityCard: View {
    let facilityReview: FacilityReview
    
    @State private var isExpanded: Bool = false
    @State private var isScrapped: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            topInfo
            Spacer() .frame(height: 15)
            locationName
            Spacer() .frame(height: 5)
            ReviewLocation()
            urlReviewImage
            ReviewText(text: facilityReview.tips, isExpanded: $isExpanded)
               
            if isExpanded {
                HeartandComment(facilityReview)
                WholeReviewBtn()
                        }
            
        }
        .padding(20) /// 안쪽 여백
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.grayColorI)
                .stroke(Color.mainColorE, lineWidth: 1)
                //.frame(width: 360)
        )
        .frame(width: 360)
        //.border(Color.red)
        
    }
    
    //MARK: - 상단 프로필 + 정보
    private var topInfo : some View {
        HStack {
            urlProfileImage
            Spacer().frame(width: 14)
            VStack(alignment: .leading, spacing: 3){
                Text("\(facilityReview.userId)")
                    .font(.mainTextMedium16)
                HStack{
                    Text(facilityReview.hallName)
                        .foregroundStyle(.grayColorE)
                    Text("|")
                        .foregroundStyle(.grayColorG)
                    Text(isScrapped ? "스크랩 수 \(facilityReview.scrapCount+1)" : "스크랩 수 \(facilityReview.scrapCount)")
                        .foregroundStyle(.grayColorE)
                }
                .font(.mainTextMedium14)
            }
            Spacer()
            Button(action: {
                isScrapped.toggle()
            }) {
                Image(isScrapped ? .scrapBookMark : .scrap)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }
        }
    }
    
    //MARK: - 편의시설 종류
    private var locationName : some View {
        Text(facilityReview.facilityName)
            .font(.mainTextSemiBold18)
            .foregroundColor(.grayColorA)
    }
    
    //MARK: - 프로필 사진
    @ViewBuilder
    private var urlProfileImage : some View {
        if let profileUrl = URL(string: facilityReview.userImageUrl), !facilityReview.userImageUrl.isEmpty {
            KFImage(profileUrl)
                .placeholder({
                    ProgressView()
                        .controlSize(.mini)
                }).retry(maxCount: 2, interval: .seconds(2))
                .onFailure { error in
                    print("이미지 로드 실패: \(error)")
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
    }
    
    //MARK: - 리뷰 사진
    @ViewBuilder
    private var urlReviewImage : some View {
        if let urlStr = facilityReview.imageUrl,
            let url = URL(string: urlStr),
           !urlStr.isEmpty {
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
                .frame(width: 127, height: 127)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

#Preview {
    ReviewFacilityCard(
        facilityReview: .init(
            id: 1,
            userId: 777,
            userImageUrl: "https://picsum.photos/80",
            hallName: "KSPO DOME",
            scrapCount: 10,
            facilityName: "주차장",
            latitude: "37.51234",
            longitude: "127.09876",
            imageUrl: "https://picsum.photos/340",
            tips: "주차할 공간 많이 없을 때는 한국체대 쪽에 주차하고 오시는 거 추천드려요... 안쪽 들어가면 차가 너무 많아서 나올때도 힘들거든요. 주차요금도 생각보다 괜찮아요.",
            likeCount: 12,
            commentCount: 3
        )
    )
}
