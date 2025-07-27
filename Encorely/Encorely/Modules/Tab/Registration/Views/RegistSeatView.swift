//
//  RegistVSRView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

/// 좌석등록 sheet

struct RegistSeatView: View {
    
    @State private var text = ""
    @State private var isChecked: Bool = false
    @Binding var showSheet: SheetType?
    
    var body: some View {
        NavigationStack {
            registSeatView
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: 좌석 등록
    private var registSeatView: some View {
        VStack(alignment: .leading, spacing: 20) {
            RegistProgress(progressStep: 2)
            venueLocation
                .padding(.bottom, 5)
            seatTextField
            Spacer()
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
    
    private var seatTextField: some View {
        VStack(spacing: 20) {
            HStack(spacing: 21) {
                TextField("", text: $text)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 12)
                    .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium16)
                Text("구역")
                    .font(.mainTextMedium20)
                    .foregroundStyle(.grayScaleA)
            }
            HStack(spacing: 23) {
                HStack(spacing: 21) {
                    TextField("", text: $text)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 12)
                        .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium16)
                    Text("열")
                        .font(.mainTextMedium20)
                        .foregroundStyle(.grayScaleA)
                }
                HStack(spacing: 21) {
                    TextField("", text: $text)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 12)
                        .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium20)
                    Text("번")
                        .font(.mainTextMedium20)
                        .foregroundStyle(.grayScaleA)
                }
            }
        }
    }
    
    // MARK: 다음 버튼
    private var nextBtn: some View {
        NavigationLink (
            destination: RegistRateView(showSheet: $showSheet),
            label: { MainRegistBtn(mainRegistType: .init(title: "다음"))
        })
    }
}


#Preview {
    RegistSeatView(showSheet: .constant(nil))
}
