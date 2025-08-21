//
//  RegistVenueView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

/// 공연장 등록 sheet

struct RegistVenueView: View {
    
    @EnvironmentObject var container: DIContainer
    @Binding var showSheet: SheetType?
    
    private var viewModel: RegistViewModel {
        container.registViewModel
    }
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination) {
            registVenueView
                .navigationDestination(for: NavigationDestination.self) { destination in
                    NavigationRoutingView(
                        destination: destination,
                        showSheet: $showSheet
                    )
                }
        }
        .task {
            if container.registViewModel.venues.isEmpty {
                await container.registViewModel.fetchAllVenues(using: container.venueSelectionService)
            }
        }
    }
    
    // MARK: 공연장 등록
    private var registVenueView: some View {
        VStack(alignment: .leading, spacing: 20) {
            RegistProgress(progressStep: 1)
                .padding(.horizontal, 16)
            LeftSearchBar(leftSearchBarType: .init(title: "내가 찾고 싶은 공연장을 검색하세요"))
                .padding(.horizontal, 16)
            searchList
            nextBtn(viewModel: container.registViewModel, router: container.navigationRouter)
                .padding(.horizontal, 16)
        }
        
    }
    
    /// 공연장 리스트
    private var searchList: some View {
        RegistVenueListView(viewModel: container.registViewModel)
    }
    
    
    // MARK: 다음 버튼
    private struct nextBtn: View {
        @ObservedObject var viewModel: RegistViewModel
        var router: NavigationRouter
        
        var body: some View {
            let enabled = viewModel.isVenueStepValid
            
            return Button {
                if enabled { router.push(to: .registSeat) }
            } label: {
                MainRegistBtn(mainRegistType: .init(title: "다음"))
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(enabled ? Color.mainColorB : Color.grayColorG)
                            .frame(height: 54)
                    )
            }
            .disabled(!enabled)
            .animation(.easeInOut(duration: 0.2), value: enabled)
        }
    }
}


#Preview {
    RegistVenueView(showSheet: .constant(nil))
        .environmentObject(DIContainer())
}
