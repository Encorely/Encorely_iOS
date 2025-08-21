//
//  ReviewFnbCard.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import SwiftUI
import Kingfisher

struct ReviewFnbCard: View {
    let fnbReview: FnbReview
    
    @State private var isExpanded: Bool = false
    @State private var showAllTags: Bool = false
    @State private var isScrapped: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            topInfo
            Spacer() .frame(height: 15)
            locationName
            Spacer() .frame(height: 5)
            ReviewLocation()
            reviewImage
            ReviewText(text: fnbReview.restaurantDetail, isExpanded: $isExpanded)
            ReviewRatingTags(
                tags: fnbReview.keywords,
                isExpanded: isExpanded,
                showAllTags: $showAllTags
            )
            .onChange(of: isExpanded) {
                if !isExpanded {
                    showAllTags = false
                }
            }
        if isExpanded {
            HeartandComment(fnbReview)
            WholeReviewBtn()
            }
        }
        .padding(20) /// 안쪽 여백
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.grayColorI)
                .stroke(Color.mainColorE, lineWidth: 1)
        )
        .frame(width: 360)
    }
    
    ///미리보기용... 스웨거엔 배열이 아니라서 사진이 무조건 하나인지..?
    private var reviewImage : some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack{
                urlReviewImage
                urlReviewImage
                urlReviewImage
            }
        }
        .frame(height:140)
    }
    
    //MARK: - 상단 프로필 + 정보
    private var topInfo : some View {
        HStack {
            urlProfileImage
            Spacer().frame(width: 14)
            VStack(alignment: .leading, spacing: 3){
                Text("\(fnbReview.userId)")
                    .font(.mainTextMedium16)
                HStack{
                    Text("\(fnbReview.hallName) 부터 \(fnbReview.distance)m")
                        .foregroundStyle(.grayColorE)
                        .lineLimit(1) ///한 줄 고정
                        .minimumScaleFactor(0.95) ///넘치면 살짝 줄어들게
                    Text("|")
                        .foregroundStyle(.grayColorG)
                    Text(isScrapped ? "스크랩 수 \(fnbReview.scrapCount+1)" : "스크랩 수 \(fnbReview.scrapCount)")
                        .foregroundStyle(.grayColorE)
                }
                .font(.mainTextMedium14)
                //.frame(width:240)
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
    
    //MARK: - 맛집 이름
    private var locationName : some View {
        Text(fnbReview.restaurantName)
            .font(.mainTextSemiBold18)
            .foregroundColor(.grayColorA)
    }
    
    //MARK: - 프로필 사진
    @ViewBuilder
    private var urlProfileImage : some View {
        if let profileUrl = URL(string: fnbReview.userImageUrl), !fnbReview.userImageUrl.isEmpty {
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
        if let urlStr = fnbReview.imageUrl,
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
    ReviewFnbCard(
        fnbReview: .init(
            id: 1,
            userId: 777,
            userImageUrl: "https://picsum.photos/80",
            hallName: "KSPO DOME",
            distance: 203,
            scrapCount: 10,
            restaurantName: "연남살롱",
            latitude: "37.51234",
            longitude: "127.09876",
            imageUrl: "https://picsum.photos/340",
            restaurantDetail: "시그니처 메뉴가 진짜 맛있어요. 공연 끝나고 가볍게 들르기 딱 좋았어요!",
            keywords: ["가성비 좋아요", "분위기 좋아요", "단체 가능"],
            numOfKeywords: 5,
            likeCount: 12,
            commentCount: 3
        )
    )
}
