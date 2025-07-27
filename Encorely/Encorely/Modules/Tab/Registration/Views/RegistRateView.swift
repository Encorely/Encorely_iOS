//
//  RegistVSRView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

/// 좌석 평가 sheet

struct RegistRateView: View {
    
    @State private var rating: Int = 0
    @State private var isChecked: Bool = false
    @State private var detailSeatReview = ""
    
    let goodkeywordList = KeywordType.goodSeatTag
    let badkeywordList = KeywordType.badSeatTag
    
    @Binding var showSheet: SheetType?
    
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
        .padding(.horizontal, 16)
    }
    
    private var venueLocation: some View {
        Button (action:{
            
        }) {
            HStack(spacing: 5) {
                Image(.location)
                    .resizable()
                    .frame(width: 12, height: 15)
                Text("고척 스카이돔")
                    .font(.mainTextMedium16)
            }
            .foregroundStyle(.grayScaleH)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.mainColorD)
                    .stroke(.mainColorH, lineWidth: 1)
                
            }
        }
    }
    
    private var seatInfo: some View {
        Text("413구역 E열 10번")
            .frame(maxWidth: .infinity)
            .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium20)
            .padding(.horizontal, 1)
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
    }
    
    private var starRating: some View {
        RateView(
            currentStar: $rating,
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        HStack(spacing: 15) {
                            ForEach(0...4, id: \.self) { index in
                                GoodKeywordRating(keywordType: goodkeywordList[index])
                            }
                        }
                        .padding(1)
                        
                        HStack(spacing: 15) {
                            ForEach(5...8, id: \.self) { index in
                                GoodKeywordRating(keywordType: goodkeywordList[index])
                            }
                        }
                        .padding(1)
                        
                        HStack(spacing: 15) {
                            ForEach(9...13, id: \.self) { index in
                                GoodKeywordRating(keywordType: goodkeywordList[index])
                            }
                        }
                        .padding(1)
                        
                    }
                }
            }
            VStack {
                HStack {
                    Text("이런 점이 아쉬워요")
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        HStack(spacing: 15) {
                            ForEach(0...3, id: \.self) { index in
                                GoodKeywordRating(keywordType: badkeywordList[index])
                            }
                        }
                        .padding(1)
                        
                        HStack(spacing: 15) {
                            ForEach(4...7, id: \.self) { index in
                                GoodKeywordRating(keywordType: badkeywordList[index])
                            }
                        }
                        .padding(1)
                        
                        HStack(spacing: 15) {
                            ForEach(8...11, id: \.self) { index in
                                GoodKeywordRating(keywordType: badkeywordList[index])
                            }
                        }
                        .padding(1)
                        
                    }
                }
            }
        }
    }
    
    
    // MARK: 좌석 자세한 후기 TextEditor
    private var bottomContents: some View {
        VStack(spacing: 23) {
            HStack(spacing: 15) {
                Button(action: {
                    isChecked.toggle()
                }) {
                    Image(isChecked ? .fullCheck : .emptyCheck)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text("좌석에 대해 더 자세한 후기를 남길래요")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(isChecked ? .grayScaleA : .grayScaleL)
                Spacer()
            }
            if isChecked {
                TextEditor(text: $detailSeatReview)
                    .detailTextFieldModifier(height: 230, font: .mainTextMedium16
                    )
            }
        }
    }
    
    
    // MARK: 다음 버튼
    private var nextBtn: some View {
        Button(action: {
            showSheet = nil
        }) {
            MainRegistBtn(mainRegistType: .init(title: "완료"))
        }
    }
}


#Preview {
    RegistRateView(showSheet: .constant(nil))
}
