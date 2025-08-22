//
//  MainVenueListView.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI

struct VenueListView: View {
    @Environment(\.dismiss) var dismiss
    //@StateObject var viewModel = RegistViewModel()
    @Environment(HallViewModel.self) private var viewModel
    
    var body: some View {
        topSearchBar
        venueList
            .navigationBarBackButtonHidden()
    }
    
    //MARK: - 상단 검색 바
    private var topSearchBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(.chevronLeft)
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.grayColorA)
            }
            RightSearchBar(rightSearchBarType: .init(title: "내가 찾고 싶은 공연장을 입력해보세요"))
        }
        .padding(.horizontal,16)
        .padding(.top,30)
    }
    
    //MARK: - 공연장 리스트
    private var venueList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.halls) { hall in
                    Button (action: {
                        
                    }) {
                        MainVenueCard(hallRanking: hall)
                    }
                }
            }
            .task {
                await viewModel.loadHalls() /// 불러오기이이이이이ㅣㅇㄱ
                print("viewModel.halls.count = \(viewModel.halls.count)") ///연결되고있는지 로그 확인용으로 넣어놧어용
            }
        }
    }
}
/*
#Preview {
    VenueListView()
}*/

