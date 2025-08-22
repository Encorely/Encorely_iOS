//
//  RegistVSRView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

/// 좌석 평가 sheet

struct RegistRateView: View {
    
    @EnvironmentObject var container: DIContainer
    @Environment(\.dismiss) private var dismiss

    @Binding var showSheet: SheetType?
    
    let goodkeywordList = KeywordType.goodSeatTag
    let badkeywordList = KeywordType.badSeatTag
    let onComplete: () -> Void
    
    private var viewModel: RegistViewModel {
        container.registViewModel
    }
    
    var body: some View {
        ratingSeatView
            .navigationBarBackButtonHidden(true)
    }
    
    // MARK: 좌석 평가
    private var ratingSeatView: some View {
        VStack(alignment: .leading, spacing: 0) {
            RegistProgress(progressStep: 3)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    topContents
                    
                    middleContents
                    
                    bottomContents
                }
                .padding(.bottom, 16)
            }
            .padding(.bottom, 16)
            nextBtn
        }
    }
    
    private var venueLocation: some View {
        if let selected = container.registViewModel.selectedVenue {
            return AnyView(
                HStack(spacing: 5) {
                    Image("location")
                        .resizable()
                        .frame(width: 12, height: 15)
                    Text(selected.name)
                        .font(.mainTextMedium16)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .foregroundStyle(.grayColorF)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.mainColorH)
                        .strokeBorder(.mainColorF, lineWidth: 1)
                }
            )
        } else {
            return AnyView(EmptyView())
        }
    }
    
    private var seatInfo: some View {
        Text("\(container.registViewModel.zone)구역 \(container.registViewModel.rows)열 \(container.registViewModel.num)번")
            .frame(maxWidth: .infinity)
            .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium20)
    }
    
    private var topContents: some View {
        VStack(spacing: 25) {
            HStack {
                venueLocation
                    .padding(.leading, 1)
                    .padding(.top, 20)
                Spacer()
            }
            seatInfo
            starRating
                .padding(.top, 5)
            
        }
        .padding(.horizontal, 16)
    }
    
    private var starRating: some View {
        RateView(
            currentStar: $container.registViewModel.rating,
            starNumber: 5,
            filledImageName: "fillStar",
            emptyImageName: "emptyStar"
        )
    }
    
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: 45) {
            VStack {
                HStack {
                    Text("이런 점이 좋아요")
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        HStack(spacing: 15) {
                            ForEach(0...4, id: \.self) { index in
                                GoodKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: goodkeywordList[index]
                                )
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(5...8, id: \.self) { index in
                                GoodKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: goodkeywordList[index]
                                )
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(9...13, id: \.self) { index in
                                GoodKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: goodkeywordList[index]
                                )
                            }
                        }
                        
                    }
                }
                .padding(.leading, 16)
            }
            VStack {
                HStack {
                    Text("이런 점이 아쉬워요")
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        HStack(spacing: 15) {
                            ForEach(0...3, id: \.self) { index in
                                BadKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: badkeywordList[index]
                                )
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(4...7, id: \.self) { index in
                                BadKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: badkeywordList[index]
                                )
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(8...10, id: \.self) { index in
                                BadKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: badkeywordList[index]
                                )
                            }
                        }
                        
                    }
                }
                .padding(.leading, 16)
            }
        }
    }
    
    
    // MARK: 좌석 자세한 후기 TextEditor
    private var bottomContents: some View {
        seatDetailToggleView(viewModel: container.registViewModel)
            .padding(.horizontal, 16)
    }
    
    private struct seatDetailToggleView: View {
        @ObservedObject var viewModel: RegistViewModel

        var body: some View {
            VStack(spacing: 23) {
                Button {
                    viewModel.isCheckedSeat.toggle()
                } label: {
                    HStack(spacing: 15) {
                        Image(viewModel.isCheckedSeat ? .fullCheck : .emptyCheck)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("좌석에 대해 더 자세한 후기를 남길래요")
                            .font(.mainTextSemiBold18)
                            .foregroundStyle(viewModel.isCheckedSeat ? .grayColorA : .grayColorG)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                if viewModel.isCheckedSeat {
                    TextEditor(text: $viewModel.detailSeatReview)
                        .detailTextFieldModifier(height: 230, font: .mainTextMedium16)
                }
            }
        }
    }
    
    
    // MARK: 완료 버튼
    private var nextBtn: some View {
        let enabled = container.registViewModel.rating > 0

        return Button(action: {
            guard enabled else { return }
            showSheet = nil

            container.navigationRouter.popToRootView()
            
            onComplete()
        }) {
            MainRegistBtn(mainRegistType: .init(title: "완료"))
                .background (
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(enabled ? Color.mainColorB : Color.grayColorG)
                        .frame(height: 54)
                )
        }
        .padding(.horizontal, 16)
        .disabled(!enabled)
        .animation(.easeInOut(duration: 0.15), value: enabled)
    }
}


#Preview {
    let container = DIContainer()
    container.registViewModel = RegistViewModel()
    
    return RegistRateView(
        showSheet: .constant(nil),
        onComplete: { }
    )
    .environmentObject(container)
}
