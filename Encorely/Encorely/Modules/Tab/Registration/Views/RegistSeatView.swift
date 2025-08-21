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
    @Binding var showSheet: SheetType?
    let onComplete: () -> Void
    
    private var viewModel: RegistViewModel {
        container.registViewModel
    }
    
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
    
    
    
    private var seatTextField: some View {
        VStack(spacing: 20) {
            HStack(spacing: 21) {
                TextField("", text: $container.registViewModel.zone)
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
                    TextField("", text: $container.registViewModel.rows)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 12)
                        .purpleBorderTextFieldModifier(height: 60, font: .mainTextMedium20)
                        .multilineTextAlignment(.center)
                    Text("열")
                        .font(.mainTextMedium20)
                        .foregroundStyle(.grayColorA)
                }
                HStack(spacing: 21) {
                    TextField("", text: $container.registViewModel.num)
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
        // 공백만 입력하는 경우도 막기 위해 trim
        let zoneOK = !container.registViewModel.zone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let rowOK  = !container.registViewModel.rows.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let numOK  = !container.registViewModel.num.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let enabled = zoneOK && rowOK && numOK
        
        return Button {
            guard enabled else { return }
            container.navigationRouter.push(to: .registRating)
        } label: {
            MainRegistBtn(mainRegistType: .init(title: "다음"))
                .background (
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(enabled ? Color.mainColorB : Color.grayColorG)
                        .frame(height: 54)
                )
        }
        .disabled(!enabled)
        .animation(.easeInOut(duration: 0.15), value: enabled)
    }
}


#Preview {
    let container = DIContainer()
    container.registViewModel = RegistViewModel()
    
    return RegistSeatView(
        showSheet: .constant(nil),
        onComplete: { }
    )
    .environmentObject(container)
}
