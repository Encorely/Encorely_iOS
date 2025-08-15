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
    @ObservedObject var viewModel: RegistViewModel
    
    let goodkeywordList = KeywordType.goodSeatTag
    let badkeywordList = KeywordType.badSeatTag
    
    @Binding var showSheet: SheetType?
    @Environment(\.dismiss) private var dismiss
    
    let onComplete: () -> Void
    
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
        Button (action:{
            
        }) {
            HStack(spacing: 5) {
                Image("location")
                    .resizable()
                    .frame(width: 12, height: 15)
                Text("고척 스카이돔")
                    .font(.mainTextMedium16)
            }
            .foregroundStyle(.grayColorF)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.mainColorH)
                    .strokeBorder(.mainColorF, lineWidth: 1)
                
            }
        }
    }
    
    private var seatInfo: some View {
        Text("\(viewModel.zone)구역 \(viewModel.rows)열 \(viewModel.num)번")
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
            currentStar: $viewModel.rating,
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
                                GoodKeywordRating(keywordType: goodkeywordList[index])
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(5...8, id: \.self) { index in
                                GoodKeywordRating(keywordType: goodkeywordList[index])
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(9...13, id: \.self) { index in
                                GoodKeywordRating(keywordType: goodkeywordList[index])
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
                                BadKeywordRating(keywordType: badkeywordList[index])
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(4...7, id: \.self) { index in
                                BadKeywordRating(keywordType: badkeywordList[index])
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(8...11, id: \.self) { index in
                                BadKeywordRating(keywordType: badkeywordList[index])
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
        VStack(spacing: 23) {
            HStack(spacing: 15) {
                Button(action: {
                    viewModel.isCheckedSeat.toggle()
                }) {
                    Image(viewModel.isCheckedSeat ? .fullCheck : .emptyCheck)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text("좌석에 대해 더 자세한 후기를 남길래요")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(viewModel.isCheckedSeat ? .grayColorA : .grayColorG)
                Spacer()
            }
            if viewModel.isCheckedSeat {
                TextEditor(text: $viewModel.detailSeatReview)
                    .detailTextFieldModifier(height: 230, font: .mainTextMedium16
                    )
            }
        }
        .padding(.horizontal, 16)
    }
    
    
    // MARK: 완료 버튼
    private var nextBtn: some View {
        Button(action: {
            onComplete()
        }) {
            MainRegistBtn(mainRegistType: .init(title: "완료"))
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    let vm = RegistViewModel()
    vm.zone = "12"
    vm.rows = "4"
    vm.num = "8"
    
    let container = DIContainer()

    return RegistRateView(
        viewModel: vm,
        showSheet: .constant(nil),
        onComplete: { print("완료됨") }
    )
        .environmentObject(container)
}
