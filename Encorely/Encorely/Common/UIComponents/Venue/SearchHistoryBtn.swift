//
//  SearchHistoryBtn.swift
//  Encorely
//
//  Created by 이예지 on 7/14/25.
//

import SwiftUI

/// 검색기록
struct SearchHistoryBtn: View {
    
    let searchHistoryItem: SearchHistoryItem
    
    var body: some View {
            HStack(spacing: 8) {
                historyKeyword
                removeHistory
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 9.5)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.mainColorH)
            }
    }
    
    // MARK: 검색기록 키워드  ex) 하이라이트 콘서트
    private var historyKeyword: some View {
        Button(action: {
            //TODO: 검색어로 이동
        }) {
            Text(searchHistoryItem.keyword)
                .foregroundStyle(.mainColorC)
                .font(.mainTextMedium17)
        }
    }
    
    // MARK: 키워드 삭제버튼  ( X )
    private var removeHistory: some View {
        Button(action: {
            //TODO: 검색어 삭제
        }) {
            Image(systemName: "multiply")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundStyle(.mainColorC)
        }
    }
}

#Preview {
    SearchHistoryBtn(searchHistoryItem: .init(keyword: "하이라이트 콘서트", searchDate: "2022-01-25 00:53:06 +0000"))
}
