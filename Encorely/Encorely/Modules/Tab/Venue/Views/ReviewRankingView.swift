//
//  ReviewRankingView.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI

struct ReviewRankingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            LeftSearchBar(leftSearchBarType: .init(title: "공연 후기를 검색해보세요"))
                .padding(.horizontal, 16)
                .padding(.top, 20)
            reviewRankingGrid
                .navigationBarBackButtonHidden()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: { dismiss() }) {
                    Image(.chevronLeft)
                        .frame(width: 25, height: 25)
                }
            })
            
            ToolbarItem(placement: .principal, content: {
                Text("현재 진행 중인 공연  ")
                    .font(.mainTextSemiBold20)
            })
        })
    }
    
    //MARK: - 화제의 후기 그리드
    private var reviewRankingGrid: some View {
        let reviews = ReviewRankingMock
        let columns = [
                GridItem(.flexible(), spacing: 15),
                GridItem(.flexible())
            ]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 45) {
                ForEach(reviews) { review in
                    ReviewRankingCard(reviewRanking: review)
                }
            }
        }
        .contentMargins(16, for: .scrollContent)
        //.padding(16)
    }
}

#Preview {
    ReviewRankingView()
}
