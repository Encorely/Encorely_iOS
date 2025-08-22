//
//  OngoingShowDetailView.swift
//  Encorely
//
//  Created by 이민서 on 8/15/25.
//

import SwiftUI
import Kingfisher

struct OngoingShowDetailView: View {
    let ongoingShowDetail : OngoingShowDetail
    @Environment(\.dismiss) var dismiss
    
    fileprivate enum PerformanceDetailContents {
        static let topStatusVspacing: CGFloat = 12
        static let sheetBottomHspacing: CGFloat = 10
        static let sheetMiddleCalendarVspacing: CGFloat = 8
        static let sheetMiddleCalendarPadding: CGFloat = 15
        static let sheetMiddleVspacing: CGFloat = 14
        static let sheetContentsVspacing: CGFloat = 25
        
        static let sheetPadding: CGFloat = 16
        static let safeHoriozontalPadding: CGFloat = 16
        static let safeTopPadding: CGFloat = 30
        static let sheetHeight: CGFloat = 450
        
        static let topBgImageSize: CGFloat = 308
        static let backImageSize: CGSize = .init(width: 25, height: 25)
        static let sheetSize: CGSize = .init(width: 360, height: 75)
        static let sheetBottomBtnSize: CGFloat = 40
        
        static let retryCount: Int = 2
        static let retryTime: TimeInterval = 2
        static let opacity: Double = 0.5
        static let sheetCornerRadius: CGFloat = 15
        
        static let sheetMiddleCalendarText: String = "일반 예매일"
        static let topLeadingBackBtn: String = "icon_pin"
        static let backImageBtn: String = "chevron.left"
        static let scheduleText: String = "관람 일정"
        static let locationText: String = "관람 장소"
        static let ageText: String = "관람 연령"
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom, content: {
            topContents
            sheetContents
                .navigationBarBackButtonHidden(true)
        })
        .overlay(alignment: .top, content: {
            topStatus
                .padding(.top, PerformanceDetailContents.safeTopPadding)
                .padding(.horizontal, PerformanceDetailContents.safeHoriozontalPadding)
        })
    }
   
    // MARK: - TopContents
    /// 상단 네비게이션 상태 바
    private var topStatus: some View {
        ZStack(alignment: .leading, content: {
            HStack {
                Text(ongoingShowDetail.showName)
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(Color.white)
                    .frame(width:200)
                    .lineLimit(1) ///한 줄만 표시
                    .truncationMode(.tail) ///뒤쪽 자르기
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Button(action: { dismiss() }) {
                Image(.chevronLeft)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.white)
                    .frame(width: PerformanceDetailContents.backImageSize.width, height: PerformanceDetailContents.backImageSize.height)
            }
        })
    }
    
    /// 상단 탑 컨텐츠
    private var topContents: some View {
        VStack {
            topBackgrundImage
            Spacer()
                .border(Color.red)
        }
    }
    
    /// 상단 탑 백그라운드 이미지
    @ViewBuilder
    private var topBackgrundImage : some View {
        if let url = URL(string: ongoingShowDetail.imageUrl) {
            KFImage(url)
                .placeholder({
                    ProgressView()
                        .controlSize(.regular)
                }).retry(maxCount: PerformanceDetailContents.retryCount, interval: .seconds(PerformanceDetailContents.retryTime))
                .onFailure { error in
                    print("이미지 로드 실패: \(error)")
                }
                .resizable()
                //.scaledToFill()
                .clipped()
                .overlay {
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(PerformanceDetailContents.opacity)]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                }
                .frame(height: PerformanceDetailContents.topBgImageSize)
                .clipped()
            
        }
    }
 
    // MARK: - Middle
    /// 시트 내부 컨텐츠
    private var sheetContents: some View {
        VStack(alignment: .leading, spacing: PerformanceDetailContents.sheetContentsVspacing, content: {
            sheetTopTitle
            sheetMiddleInfo
            Spacer()
            MainRegistBtn(mainRegistType: .init(title: "예매하러 가기"))
        })
        .frame(height: PerformanceDetailContents.sheetHeight)
        .padding(.horizontal, PerformanceDetailContents.sheetPadding)
        .safeAreaPadding(.top, PerformanceDetailContents.safeTopPadding)
        .background {
            UnevenRoundedRectangle(topLeadingRadius: PerformanceDetailContents.sheetCornerRadius, topTrailingRadius: PerformanceDetailContents.sheetCornerRadius)
                .fill(Color.white)
        }
        
    }
    
    /// 시트 상단 타이틀
    private var sheetTopTitle: some View {
        VStack(alignment: .leading, spacing: PerformanceDetailContents.topStatusVspacing, content: {
            Text(ongoingShowDetail.showName)
                .font(.mainTextSemiBold18)
            HStack{
                Image(.location)
                    .foregroundStyle(.mainColorG)
                Text(ongoingShowDetail.hallName)
                    .font(.mainTextMedium14)
                    .foregroundStyle(.grayColorC)
                    .underline(color: .grayColorC)
            }
        })
    }
    
    /// 시트 중간 공연 정보 및 일정
    private var sheetMiddleInfo: some View {
        VStack(alignment: .leading, spacing: PerformanceDetailContents.sheetMiddleVspacing, content: {
            sheetMiddleCalendar
            Spacer().frame(height: 8)
            sheetMiddleTextInfo
        })
    }
    
    /// 시트 중간 일정 컨텐츠
    private var sheetMiddleCalendar: some View {
        VStack(alignment: .leading, spacing: PerformanceDetailContents.sheetMiddleCalendarVspacing) {
            Text(PerformanceDetailContents.sheetMiddleCalendarText)
                .font(.mainTextMedium14)
            
            Text("7/4 (금) 17:00")
                .foregroundStyle(.subColorB)
                .font(.mainTextSemiBold16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(PerformanceDetailContents.sheetMiddleCalendarPadding)
        .overlay(content: {
            RoundedRectangle(cornerRadius: PerformanceDetailContents.sheetCornerRadius)
                .fill(Color.clear)
                .stroke(Color.grayColorG, style: .init())
        })
    }
    
    private var sheetMiddleTextInfo : some View {
        VStack(alignment: .leading, spacing: PerformanceDetailContents.sheetMiddleVspacing) {
            HStack {
                Text(PerformanceDetailContents.scheduleText)
                    .font(.mainTextRegular13)
                Text("\(ongoingShowDetail.startDate)~\(ongoingShowDetail.endDate)")
                    .font(.mainTextMedium16)
            }
            HStack {
                Text(PerformanceDetailContents.locationText)
                    .font(.mainTextRegular13)
                Text(ongoingShowDetail.hallName)
                    .font(.mainTextMedium16)
            }
            HStack {
                Text(PerformanceDetailContents.ageText)
                    .font(.mainTextRegular13)
                Text("만\(ongoingShowDetail.age)세 이상")
                    .font(.mainTextMedium16)
            }
        }
        .foregroundStyle(.grayColorE)
    }
}
/*
#Preview {
    OngoingShowDetailView(
        ongoingShowDetail: OngoingShowDetail(
            imageUrl:"https://i.namu.wiki/i/7TVt2PkhyHqrvvA4eheUDkUQEf_diNpxKpHxjmDb9D00MUNc7jvXMpiMlnMXhROJMJxo_2ouBJZj5z0XFzLvJg.webp",
            showName: "2025 VIVIZ WORLD TOUR [NEW LEGACY]",
            id: 1,
            hallName: "올림픽공원 올림픽홀",
            startDate: "2025. 07. 15",
            endDate: "2025. 07. 16",
            age: 7,
            link: nil)
                                            
    )
}
*/
