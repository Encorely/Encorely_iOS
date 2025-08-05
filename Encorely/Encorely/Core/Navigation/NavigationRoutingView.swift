//
//  NavigationRoutingView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

struct NavigationRoutingView: View {
    
    @EnvironmentObject var container: DIContainer

    let destination: NavigationDestination
    
    var body: some View {
        Group {
            switch destination {
            case .venueView:
                // 공연장 탭
                VenueView()
            case .registSeat:
                // 좌석 등록
                RegistSeatView(viewModel: SubRegistViewModel(), showSheet: .constant(nil))
            case .registRating:
                // 좌석 평가
                RegistRateView(viewModel: SubRegistViewModel(), showSheet: .constant(nil))
//            case .searchPlace(let type):
                // 맛집, 편의시설 장소 등록
//                SearchPlaceView()
            }
        }
        .environmentObject(container)
    }
}
