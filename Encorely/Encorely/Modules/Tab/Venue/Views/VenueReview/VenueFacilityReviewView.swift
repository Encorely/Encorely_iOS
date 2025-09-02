//
//  VenueFacilityReviewView.swift
//  Encorely
//
//  Created by 이민서 on 8/23/25.
//

import SwiftUI

struct VenueFacilityReviewView: View {
    @State private var selectedCategory: String = "편의점" // 선택된 카테고리 상태
    private let categories = ["편의점", "화장실", "주차장", "벤치", "ATM", "기타"]
    
    var body: some View {
        ScrollView{
            VStack{
                reviewCategoryView
                HStack{
                    Spacer()
                    SortingBtn()
                }
                .padding(.top,15)
                .padding(.bottom,5)
                scrollView
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    private var reviewCategoryView: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(categories, id: \.self) { category in
                reviewCategoryBtn(
                    reviewCategoryBtnType: reviewCategoryBtnType(
                        categoryName: category,
                        isSelected: selectedCategory == category
                    ),
                    action: {
                        selectedCategory = category
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
        }
    }
}

#Preview {
    VenueFacilityReviewView()
}
