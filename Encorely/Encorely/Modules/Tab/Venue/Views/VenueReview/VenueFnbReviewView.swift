//
//  VenueFnbReviewView.swift
//  Encorely
//
//  Created by 이민서 on 8/23/25.
//

import SwiftUI

struct VenueFnbReviewView: View {
    @State private var selectedCategory: String = "밥집" // 선택된 카테고리 상태
    private let categories = ["밥집", "카페", "술집"]
    
    var body: some View {
        ScrollView{
            VStack {
                LeftSearchBar(leftSearchBarType: .init(title: "내가 찾고 싶은 맛집을 검색해보세요"))
                Spacer().frame(height:15)
                reviewCategoryView
                HStack{
                    Spacer()
                    SortingBtn()
                }
                .padding(.top,15)
                .padding(.bottom,5)
                scrollView
            }
            .padding(.horizontal,16)
            .padding(.top, 20)
        }
    }
    
    private var reviewCategoryView : some View {
        HStack(spacing: 12) {
            ForEach(categories, id: \.self) { category in
                reviewCategoryBtn(
                    reviewCategoryBtnType: reviewCategoryBtnType(
                        categoryName: category,
                        isSelected: selectedCategory == category
                    ),
                    action: {
                        selectedCategory = category // 선택된 카테고리 갱신
                    }
                )
            }
        }
    }
    
    private var scrollView: some View {
        /// 임의로 넣은 것  - 나중에 ViewModel에서 가져와야 함
        let cards = [1, 2, 3, 4, 5]

        return LazyVStack(spacing: 25) {
            ForEach(cards, id: \.self) { _ in
                ReviewFnbCard(fnbReview: .init(
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
                ))
            }
        }
    }
}

#Preview {
    VenueFnbReviewView()
}

