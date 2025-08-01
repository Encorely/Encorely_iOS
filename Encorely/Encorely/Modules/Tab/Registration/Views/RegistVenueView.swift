//
//  RegistVSRView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

/// 공연장 등록 sheet

struct RegistVenueView: View {
    
    @StateObject var viewModel = SubRegistViewModel()
    
    @Binding var showSheet: SheetType?
    
    var body: some View {
        NavigationStack {
            registVenueView
        }
    }
    
    // MARK: 공연장 등록
    private var registVenueView: some View {
        VStack(alignment: .leading, spacing: 20) {
            RegistProgress(progressStep: 1)
            LeftSearchBar(leftSearchBarType: .init(title: "내가 찾고 싶은 공연장을 검색하세요"))
            searchList
            nextBtn
        }
        .padding(.horizontal, 16)
    }
    
    /// 공연장 리스트
    private var searchList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.venues, id: \.name) { venue in
                    Button (action: {
                        
                    }) {
                        SubVenueCard(searchVenueResponse: venue)
                    }
                }
            }
            .onAppear {
                Task {
                    let service = MockVenueSelectionService()
                    let result = try? await service.getAllVenues()
                    self.viewModel.venues = result ?? []
                }
            }
        }
    }
    
    
    
    
    // MARK: 다음 버튼
    private var nextBtn: some View {
        NavigationLink (
            destination: RegistSeatView(viewModel: SubRegistViewModel(), showSheet: $showSheet),
            label: { MainRegistBtn(mainRegistType: .init(title: "다음"))
            })
    }
}


#Preview {
    RegistVenueView(showSheet: .constant(nil))
}
