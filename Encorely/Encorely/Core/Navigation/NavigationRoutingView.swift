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
    @Binding var showSheet: SheetType?
    let onComplete: () -> Void
    
    var body: some View {
        Group {
            switch destination {
            case .venueView:
                // 공연장 탭
                VenueView()
            case .registSeat:
                // 좌석 등록
                RegistSeatView(viewModel: RegistViewModel(),
                               showSheet: .constant(nil),
                               onComplete: onComplete
                )
            case .registRating:
                // 좌석 평가
                RegistRateView(
                    viewModel: RegistViewModel(),
                    showSheet: .constant(nil),
                    onComplete: onComplete
                )
//            case .searchPlace(let type):
                // 맛집, 편의시설 장소 등록
//                SearchPlaceView()
            }
        }
        .environmentObject(container)
    }
}
