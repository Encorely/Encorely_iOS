//
//  RegistVenueListView.swift
//  Encorely
//
//  Created by 이예지 on 8/18/25.
//

import SwiftUI

struct RegistVenueListView: View {
    @ObservedObject var viewModel: RegistViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            if viewModel.venues.isEmpty {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("공연장을 불러오는 중…")
                        .padding(.vertical, 8)
                }
                .frame(maxWidth: .infinity, minHeight: 140)
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.venues, id: \.id) { venue in
                        let isSelected = viewModel.selectedVenue?.id == venue.id

                        Button {
                            viewModel.selectedVenue = isSelected ? nil : venue
                        } label: {
                            SubVenueCard(searchVenueResponse: venue)
                                .background(
                                    Rectangle()
                                        .foregroundStyle(isSelected ? Color.mainColorH.opacity(0.7) : Color.clear)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .id(viewModel.venues.count)
            }
        }
        .animation(.default, value: viewModel.venues.count)
    }
}
