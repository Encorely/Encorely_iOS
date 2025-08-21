//
//  ReviewSeatCard.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import SwiftUI
import Kingfisher

struct ReviewSeatCard: View {
    let seatReview: SeatReview
    
    @State private var isExpanded: Bool = false
    @State private var showAllTags: Bool = false
    @State private var isScrapped: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            topInfo
            Spacer().frame(height:15)
            ratingStar
            reviewImage
            ReviewText(text: seatReview.showDetail, isExpanded: $isExpanded)
            ReviewRatingTags(tags: seatReview.keywords, isExpanded: isExpanded, showAllTags: $showAllTags)
                .onChange(of: isExpanded) {
                    if !isExpanded {
                        showAllTags = false
                    }
                }
            if isExpanded {
                HeartandComment(seatReview)
                WholeReviewBtn()
                        }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.grayColorI)
                .stroke(Color.mainColorE, lineWidth: 1)
        )
        .frame(width: 360)
    }
  
    //MARK: - 상단 프로필 + 정보
    private var topInfo : some View {
        HStack {
            urlProfileImage
            Spacer().frame(width: 14)
            VStack(alignment: .leading, spacing: 3){
                Text("\(seatReview.userId)")
                    .font(.mainTextMedium16)
                HStack{
                    Text("\(seatReview.seatArea)구역 \(seatReview.seatRow)열 \(seatReview.seatNumber)번")
                        .foregroundStyle(.grayColorE)
                        .lineLimit(1) ///한 줄 고정
                        .minimumScaleFactor(0.95) ///넘치면 살짝 줄어들게
                    Text("|")
                        .foregroundStyle(.grayColorG)
                    Text(isScrapped ? "스크랩 수 \(seatReview.scrapCount+1)" : "스크랩 수 \(seatReview.scrapCount)")
                        .foregroundStyle(.grayColorE)
                }
                .font(.mainTextMedium14)
            }
            Spacer().frame(width: 55)
            Button(action: {
                isScrapped.toggle()
            }) {
                Image(isScrapped ? .scrapBookMark : .scrap)
                    .frame(width: 25, height: 25)
            }
        }
    }
    
    private var ratingStar: some View {
        HStack(spacing: 5) {
            ForEach(0..<5, id: \.self) { index in
                Image(index < seatReview.rating ? .fillStar : .emptyStar)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:15)
            }
        }
    }

    
    @ViewBuilder
    private var reviewImage: some View {
        if !seatReview.imageUrls.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(seatReview.imageUrls, id: \.self) { urlStr in
                        if let url = URL(string: urlStr) {
                            KFImage(url)
                                .placeholder {
                                    ProgressView().controlSize(.mini)
                                }
                                .retry(maxCount: 2, interval: .seconds(2))
                                .onFailure { error in
                                    print("리뷰 이미지 로드 실패: \(error)")
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 127, height: 127)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(height: 140)
        }
    }

    
    @ViewBuilder
    private var urlProfileImage : some View {
        if let profileUrl = URL(string: seatReview.userImageUrl), !seatReview.userImageUrl.isEmpty {
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
    /*
    @ViewBuilder
    private var urlReviewImage : some View {
        if let url = URL(string: "https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/xs/2024/07/24/1721800706050786.jpg") {
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
    }*/
}

#Preview {
    ReviewSeatCard(
        seatReview: .init(
            id: 1,
            userId: 777,
            userImageUrl: "https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/xs/2024/07/24/1721800706050786.jpg",
            hallName: "장충체육관",
            seatArea: "106",
            seatRow: "G",
            seatNumber: "3",
            rating: 4,
            scrapCount: 10,
            commentCount: 6,
            likeCount: 12,
            imageUrls: ["https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/xs/2024/07/24/1721800706050786.jpg", "https://i.namu.wiki/i/Z4-6cZ8HHTzCw61vJDzRll8TxVPGFJyRLb8kvX_n7UjWIKeuH7cqwZlFCWnSLUP-9_Iz-K31vhIOgaVZEqavKg.webp", "https://mblogthumb-phinf.pstatic.net/MjAyNDA1MjRfNSAg/MDAxNzE2NTQ2NjUxMDY3.Ca9ZCRv7PaLrWQZWgZErzENepYldLJTiLjpIhhc4cgIg.eKlzr9f4nVkTgUBPLR0Xe5dm1MjUqWRUo3KOJatH_dsg.PNG/image.png?type=w800"],
            showDetail: "가수가 본 무대에 있었을 때는 잘 안보였는데 돌출로 나오니까 너무 잘보였어요. 시야 방해는 없었어요. 사진보다 실제로 더 가까이 보여서 꽤 좋은 자리인 것 같았어요. 아, 그리고 토롯코도 가까웠어요! 여기 오면 1열 시야 남부럽지 않은...ㅋㅋㅋ 그라운드 못 잡으면 여기로 와야지",
            keywords: ["돌출이 가까워요", "사진보다 잘 보여요", "토롯코 잘 보여요", "시야 방해가 없어요"]
        )
    )
}
