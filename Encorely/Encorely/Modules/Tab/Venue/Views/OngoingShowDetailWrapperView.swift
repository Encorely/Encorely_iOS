//
//  OngoingShowDetailWrapperView.swift
//  Encorely
//
//  Created by 이민서 on 8/23/25.
//

import SwiftUI
import Moya

struct OngoingShowDetailWrapperView: View {
    
    @Environment(ShowViewModel.self) private var viewModel
    let showId: Int
    
    var body: some View {
        Group {
            if let detail = viewModel.selectedShows[showId] {
                OngoingShowDetailView(ongoingShowDetail: detail)
            } else {
                ProgressView("불러오는 중...")
                    .task {
                        await viewModel.loadShowDetail(showId: showId)
                    }
            }
        }
    }
}
/*
#Preview {
    OngoingShowDetailWrapperView()
}
*/
