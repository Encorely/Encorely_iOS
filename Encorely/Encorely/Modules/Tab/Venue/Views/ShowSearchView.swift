//
//  ShowSearchView.swift
//  Encorely
//
//  Created by 이민서 on 8/15/25.
//


import SwiftUI

struct ShowSearchView: View {
    
    //MARK: - 더미 아이템들
    @State private var dummyItems: [SearchHistoryItem] = [
        SearchHistoryItem(keyword: "하이라이트 콘서트", searchDate: "2024-01-01"),
        SearchHistoryItem(keyword: "고척 스카이돔", searchDate: "2024-01-01"),
        SearchHistoryItem(keyword: "맛집", searchDate: "2024-01-01")
        ]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        topSearchBar
        recentSearches
            .navigationBarBackButtonHidden(true)
    }
    
    //MARK: - 상단 검색 바
    private var topSearchBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(.chevronLeft)
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.grayColorB)
            }
            RightSearchBar(rightSearchBarType: .init(title: "공연명, 아티스트, 공연장 등을 입력해보세요"))
        }
        .padding(.horizontal,16)
        .padding(.top,30)
    }
    
    //MARK: - 최근 검색어
    private var recentSearches: some View {
        VStack{
            HStack{
                Text("최근 검색어")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.grayColorA)
                Spacer()
                Button(action: {}) {
                    Text("지우기")
                        .font(.mainTextMedium14)
                        .foregroundStyle(.grayColorF)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(dummyItems, id: \.keyword) { item in
                        SearchHistoryBtn(searchHistoryItem: item)
                    }
                }
                .frame(height: 40)
            }
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    ShowSearchView()
}
