//
//  RegistPerformanceReviewView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

struct RegistPerformanceReviewView: View {
    
    @State private var isChecked: Bool = false
    @State private var simplePerformanceReview = ""
    @State private var detailPerformanceReview = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            topContents
            ScrollView(.vertical, showsIndicators: false) {
                middleContents
                    .padding(.top, 26)
                    .padding(.bottom, 27)
                bottomContents
                Spacer()
            }
            .padding(.bottom, 16)
            nextBtn
        }
        .padding(.horizontal, 16)
    }
    
    private var topContents: some View {
        HStack {
            VStack(spacing: 10) {
                Text("공연 후기")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.mainColorG)
                Rectangle()
                    .frame(width: 89, height: 2)
                    .foregroundStyle(.mainColorG)
            }
            Spacer()
        }
        .padding(.top, 26)
    }
    
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: 23) {
            Text("공연에 대한 한줄평을 남겨주세요")
                .font(.mainTextSemiBold18)
            TextEditor(text: $simplePerformanceReview)
                .detailTextFieldModifier(height: 40, font: .mainTextMedium16)
                .overlay(alignment: .bottomTrailing) {
                    Text("\(simplePerformanceReview.count) / 45")
                        .font(.mainTextMedium12)
                        .foregroundStyle(.grayScaleI)
                        .padding(.trailing, 13)
                        .padding(.bottom, 10)
                        .onChange(of: simplePerformanceReview) { oldValue, newValue in
                            if newValue.count > 45 {
                                simplePerformanceReview = String(newValue.prefix(45))
                            }
                        }
                }
        }
    }
    
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
                Text("공연에 대해 더 자세한 후기를 남길래요")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(isChecked ? .grayScaleA : .grayScaleL)
                Spacer()
            }
            if isChecked {
                TextEditor(text: $detailPerformanceReview)
                    .detailTextFieldModifier(height: 230, font: .mainTextMedium16
                    )
            }
        }
    }
    
    // MARK: 다음 버튼
    private var nextBtn: some View {
        Button(action: {
            dismiss()
        }) {
            MainRegistBtn(mainRegistType: .init(title: "완료"))
        }
    }
}

#Preview {
    RegistPerformanceReviewView()
}
