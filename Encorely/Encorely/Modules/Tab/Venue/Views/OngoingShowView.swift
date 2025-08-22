//
//  OngoingShowView.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI
import Foundation

struct OngoingShowView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ShowViewModel.self) private var viewModel
    
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
                        .foregroundStyle(.grayColorA)
                }
            })
            
            ToolbarItem(placement: .principal, content: {
                Text("현재 진행 중인 공연")
                    .font(.mainTextSemiBold20)
            })
        })
        .task {
            await viewModel.loadShows()  /// 불 러 오 기!!!!!!!!!!!
            print("viewModel.shows.count = \(viewModel.shows.count)")
        }
    }
    
    //MARK: - 현재 진행 중인 공연 그리드
    private var ongoingShowGrid: some View {
        //let show = OngoingShowMock
        let columns = [
                GridItem(.flexible(), spacing: 15),
                GridItem(.flexible())
            ]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.shows) { show in
                    NavigationLink {
                        OngoingShowDetailWrapperView(showId: show.id)
                    } label: {
                        ShowCard(ongoingShow: show)
                    }
                }
            }
        }
        .contentMargins(16, for: .scrollContent)
        //.padding(16)
    }
}
/*
#Preview {
    OngoingShowView()
}

*/
