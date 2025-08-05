//
//  RegistVSRView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

/// 좌석등록 sheet

struct RegistSeatView: View {
    
    @EnvironmentObject var container: DIContainer
    @ObservedObject var viewModel: SubRegistViewModel

    @Binding var showSheet: SheetType?
    
    @State private var seatZoneInput: String = ""
    @State private var seatRowInput: String = ""
    @State private var seatNumberInput: String = ""
    
    var body: some View {
        registSeatView
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
    
    private var seatTextField: some View {
        VStack(spacing: 20) {
            HStack(spacing: 21) {
                TextField("", text: $seatZoneInput)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 12)
                    .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium20)
                    .multilineTextAlignment(.center)
                Text("구역")
                    .font(.mainTextMedium20)
                    .foregroundStyle(.grayColorA)
            }
            HStack(spacing: 23) {
                HStack(spacing: 21) {
                    TextField("", text: $seatRowInput)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 12)
                        .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium20)
                        .multilineTextAlignment(.center)
                    Text("열")
                        .font(.mainTextMedium20)
                        .foregroundStyle(.grayColorA)
                }
                HStack(spacing: 21) {
                    TextField("", text: $seatNumberInput)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 12)
                        .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium20)
                        .multilineTextAlignment(.center)
                    Text("번")
                        .font(.mainTextMedium20)
                        .foregroundStyle(.grayColorA)
                }
            }
        }
    }
    
    // MARK: 다음 버튼
    private var nextBtn: some View {
        Button(action: {
            viewModel.zone = seatZoneInput
            viewModel.rows = seatRowInput
            viewModel.num = seatNumberInput
            
            container.navigationRouter.push(to: .registRating)
        },
            label: { MainRegistBtn(mainRegistType: .init(title: "다음"))
        })
    }
}


#Preview {
    RegistSeatView(viewModel: SubRegistViewModel(), showSheet: .constant(nil))
        .environmentObject(DIContainer())
}
