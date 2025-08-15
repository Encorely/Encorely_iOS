//
//  MainVenueListView.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI

struct VenueListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = RegistViewModel()
    
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
                ForEach(viewModel.venues, id: \.name) { venue in
                    Button (action: {
                        
                    }) {
                        MainVenueCard(searchVenueResponse: venue)
                    }
                }
            }
            .task {
                let service = MockVenueSelectionService()
                let result = try? await service.getAllVenues()
                self.viewModel.venues = result ?? []
            }
        }
    }
}

#Preview {
    VenueListView()
}

