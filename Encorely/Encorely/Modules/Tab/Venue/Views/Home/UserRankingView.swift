//
//  MainUserRankingView.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI

struct UserRankingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            LeftSearchBar(leftSearchBarType: .init(title: "내가 찾고 싶은 공연러를 검색하세요"))
                .padding(.horizontal, 16)
                .padding(.top, 20)
            userRankingGrid
                .navigationBarBackButtonHidden()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: { dismiss() }) {
                    Image(.chevronLeft)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.grayColorA)
                }
            })
            
            ToolbarItem(placement: .principal, content: {
                Text("인기 공연러")
                    .font(.mainTextSemiBold20)
            })
        })
    }
    
    //MARK: - 인기 사용자 그리드
    private var userRankingGrid: some View {
        let users = UserRankingMock
        let columns = [
                GridItem(.flexible(), spacing: 15),
                GridItem(.flexible())
            ]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(users) { user in
                    UserRankingCard(userRanking: user)
                }
            }
        }
        .contentMargins(16, for: .scrollContent)
        //.padding(16)
    }
}

#Preview {
    UserRankingView()
}
