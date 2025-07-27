//
//  NavigationRoutingView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

struct NavigationRoutingView: View {
    
    @EnvironmentObject var container: DIContainer

    /// 현재 이동할 화면을 나타내는 상태값
    @State var destination: NavigationDestination
    
    // MARK: - Body
    var body: some View {
        Group {
            switch destination {
            case .venueView:
                VenueView()
            }
        }
        .environmentObject(container)
    }
}
