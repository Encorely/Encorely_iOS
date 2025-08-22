//
//  MainHomeView.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI

struct MainHomeView: View {
    @State private var showViewModel = ShowViewModel()
    @State private var hallViewModel = HallViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                topBanner
                frequentVenueView
                ongoingPerformancesView
                bestPerformerView
                bestReviewsView
            }
            .ignoresSafeArea()
            .contentMargins(.bottom, 110, for: .scrollContent)
        }
        .enableWindowTapToHideKeyboard()
        .environment(showViewModel)
        .environment(hallViewModel) 
        .task {
            await showViewModel.loadShows()  ///현재 진행 중인 공연 불러오기
        }
    }
        
    private var topBanner : some View {
        ZStack(alignment: .bottomLeading) {
            Image(.mainHomeBanner)
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading){
                HStack {
                    Image(.ENCORELY)
                    Spacer()
                    NavigationLink(destination: ShowSearchView()) {
                        Image(.magnifyingGlass)
                            .frame(width:25, height:25)
                            .foregroundStyle(.grayColorJ)
                    }
                    Spacer().frame(width:15)
                    NavigationLink(destination: AlarmView()) {
                        Image(.alarm)
                            .frame(width:25, height:25)
                            .foregroundStyle(.grayColorJ)
                    }
                }
                Spacer().frame(height:152)
                VStack (alignment: .leading, spacing: 10) {
                    Text("단독 혜택부터 \n인기 공연 할인까지")
                        .font(.mainTextSemiBold32)
                        .foregroundStyle(.grayColorJ)
                    Text("올 여름, 다양한 이벤트를 만나보세요")
                        .font(.mainTextMedium20)
                        .foregroundStyle(.grayColorJ)
                    Spacer().frame(height:15)
                }
            }
            .padding(16)
        }
    }
    
    private var frequentVenueView : some View {
        let venues = FrequentVenueMock
        
        return VStack {
            HStack {
                Text("자주 보는 공연장")
                    .font(.mainTextSemiBold20)
                Spacer()
                
                NavigationLink(destination: VenueListView()) {
                    Image(.chevronRight)
                        .frame(width:25, height:25)
                }
            }
            Spacer().frame(height:20)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing:30) {
                    ForEach(venues) { venue in
                        HallCircleCard(hallCircleCardType: venue)
                    }
                }
            }
             /*
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing:30) {
                    ForEach(hallViewModel.hallRanking) { hall in
                        HallCircleCard(hallCircleCardType: hall)
                    }
                }
            }*/
        }
        .padding(16)
    }
    
    private var ongoingPerformancesView : some View {
        //let performances = OngoingShowMock
        
        return VStack {
            HStack {
                Text("현재 진행 중인 공연")
                    .font(.mainTextSemiBold20)
                Spacer()
                
                NavigationLink(destination: OngoingShowView()) {
                    Image(.chevronRight)
                        .frame(width:25, height:25)
                }
            }
            Spacer().frame(height:20)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing:20) {
                    ForEach(showViewModel.shows) { show in
                        NavigationLink(
                            destination: OngoingShowDetailWrapperView(showId: show.id)
                        ) {
                            ShowMainCard(ongoingShow: show)
                        }
                    }
                }
            }
//            .contentMargins(.horizontal, 16, for: .scrollContent)
        }
        .padding(16)
    }
    
    private var bestPerformerView : some View {
        let performers = UserRankingMock
        
        return VStack (alignment: .leading) {
            HStack {
                Text("인기 공연러")
                    .font(.mainTextSemiBold20)
                Spacer()
                
                NavigationLink(destination: UserRankingView()) {
                    Image(.chevronRight)
                        .frame(width:25, height:25)
                }
            }
            Text("Encorely에서 인기가 많은 사용자들을 확인해보세요!")
                .font(.mainTextMedium14)
                .foregroundStyle(.grayColorC)
            Spacer().frame(height:20)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing:20) {
                    ForEach(performers) { performer in
                        UserRankingCard(userRanking: performer)
                    }
                }
            }
        }
        .padding(16)
    }
    
    private var bestReviewsView : some View {
        let reviews = ReviewRankingMock
        
        return VStack (alignment: .leading) {
            HStack {
                Text("화제의 후기들")
                    .font(.mainTextSemiBold20)
                Spacer()
                
                NavigationLink(destination: ReviewRankingView()) {
                    Image(.chevronRight)
                        .frame(width:25, height:25)
                }
            }
            Text("Encorely에서 화제의 후기들을 만나보세요!")
                .font(.mainTextMedium14)
                .foregroundStyle(.grayColorC)
            Spacer().frame(height:20)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing:20) {
                    ForEach(reviews) { review in
                        ReviewRankingCard(reviewRanking: review)
                    }
                }
            }
        }
        .padding(16)
    }
}

#Preview {
    MainHomeView()
}
