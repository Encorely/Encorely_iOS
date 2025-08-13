//
//  OngoingShowView.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI

struct OngoingShowView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            LeftSearchBar(leftSearchBarType: .init(title: "공연장, 지역을 검색해보세요"))
                .padding(.horizontal, 16)
                .padding(.top, 20)
            ongoingShowGrid
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
                Text("현재 진행 중인 공연")
                    .font(.mainTextSemiBold20)
            })
        })
    }
    
    //MARK: - 현재 진행 중인 공연 그리드
    private var ongoingShowGrid: some View {
        let show = OngoingShowMock
        let columns = [
                GridItem(.flexible(), spacing: 15),
                GridItem(.flexible())
            ]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(show) { id in
                    ShowCard(ongoingShow: id)
                }
            }
        }
        .contentMargins(16, for: .scrollContent)
        //.padding(16)
    }
}

#Preview {
    OngoingShowView()
}
