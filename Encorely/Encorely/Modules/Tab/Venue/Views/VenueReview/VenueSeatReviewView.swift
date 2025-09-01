//
//  VenueSeatReviewView.swift
//  Encorely
//
//  Created by 이민서 on 8/23/25.
//

import SwiftUI

struct VenueSeatReviewView: View {
    @State private var section: String = ""   /// 구역
    @State private var row: String = ""       /// 열
    @State private var number: String = ""    /// 번
    
    var body: some View {
        ScrollView {
            VStack{
                searchView
                HStack{
                    Spacer()
                    SortingBtn()
                }
                .padding(.top,15)
                .padding(.bottom,5)
                scrollView
            }
            .padding(16)
        }
    }
    
    private var searchView: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("좌석을 검색해보세요")
                .font(.mainTextMedium18)
            
            HStack {
                HStack(spacing:13){
                    TextField("", text: $section)
                        .purpleBorderTextFieldModifier(height: 35, font: .mainTextMedium16)
                        .frame(width: 70, height: 35)
                        .padding(.leading,10)
                    Text("구역")
                }
                Spacer()
                HStack(spacing:13){
                    TextField("", text: $row)
                        .purpleBorderTextFieldModifier(height: 35, font: .mainTextMedium16)
                        .frame(width: 70, height: 35)
                    Text("열")
                }
                Spacer()
                HStack(spacing:13){
                    TextField("", text: $number)
                        .purpleBorderTextFieldModifier(height: 35, font: .mainTextMedium16)
                        .frame(width: 70, height: 35)
                    Text("번")
                }
            }
            .font(.mainTextMedium16)
            
            HStack{
                Spacer()
                Button(action: {}) {
                    Text("검색")
                        .foregroundStyle(.white)
                        .font(.mainTextSemiBold18)
                        .padding(.vertical,5)
                        .padding(.horizontal,16)
                        .background(Color.mainColorA)
                        .clipShape(Capsule())
                }
            }
        }
    }
    
    private var scrollView: some View {
        /// 임의로 넣은 것  - 나중에 ViewModel에서 가져와야 함
        let cards = [1, 2, 3, 4, 5]
        
        return LazyVStack(spacing: 25) {
            ForEach(cards, id: \.self) { _ in
                ReviewSeatCard(seatReview: .init(
                    id: 1,
                    userId: 777,
                    userImageUrl: "https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/xs/2024/07/24/1721800706050786.jpg",
                    hallName: "장충체육관",
                    seatArea: "106",
                    seatRow: "G",
                    seatNumber: "3",
                    rating: 5,
                    scrapCount: 10,
                    commentCount: 6,
                    likeCount: 12,
                    imageUrls: ["https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/xs/2024/07/24/1721800706050786.jpg", "https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/xs/2024/07/24/1721800706050786.jpg", "https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/xs/2024/07/24/1721800706050786.jpg"],
                    showDetail: "가수가 본 무대에 있었을 때는 잘 안보였는데 돌출로 나오니까 너무 잘보였어요. 시야 방해는 없었어요. 사진보다 실제로 더 가까이 보여서 꽤 좋은 자리인 것 같았어요. 아, 그리고 토롯코도 가까웠어요! 여기 오면 1열 시야 남부럽지 않은...ㅋㅋㅋ 그라운드 못 잡으면 여기로 와야지",
                    keywords: ["돌출이 가까워요", "사진보다 잘 보여요", "토롯코 잘 보여요", "시야 방해가 없어요"]
                )
            )
            }
        }
    }
}

#Preview {
    VenueSeatReviewView()
}
