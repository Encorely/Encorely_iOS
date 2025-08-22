//
//  RegistPerformanceReviewView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

struct RegistPerformanceReviewView: View {
    
    @EnvironmentObject var container: DIContainer
    @Environment(\.dismiss) private var dismiss
    
    private var viewModel: RegistViewModel {
        container.registViewModel
    }
    
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
                    .foregroundStyle(.mainColorD)
                Rectangle()
                    .frame(width: 89, height: 2)
                    .foregroundStyle(.mainColorD)
            }
            Spacer()
        }
        .padding(.top, 26)
    }
    
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: 23) {
            Text("공연에 대한 한줄평을 남겨주세요")
                .font(.mainTextSemiBold18)
            TextEditor(text: $container.registViewModel.simplePerformanceReview)
                .detailTextFieldModifier(height: 60, font: .mainTextMedium16)
                .overlay(alignment: .bottomTrailing) {
                    Text("\(container.registViewModel.simplePerformanceReview.count) / 45")
                        .font(.mainTextMedium12)
                        .foregroundStyle(.grayColorF)
                        .padding(.trailing, 13)
                        .padding(.bottom, 10)
                        .onChange(of: container.registViewModel.simplePerformanceReview) { oldValue, newValue in
                            if newValue.count > 45 {
                                container.registViewModel.simplePerformanceReview = String(newValue.prefix(45))
                            }
                        }
                }
        }
    }
    
    private var bottomContents: some View {
        performanceDetailToggleView(viewModel: container.registViewModel)
    }
    
    private struct performanceDetailToggleView: View {
        @ObservedObject var viewModel: RegistViewModel
        
        var body: some View {
            VStack(spacing: 23) {
                Button(action: {
                    viewModel.isCheckedPerformance.toggle()
                }) {
                    HStack(spacing: 15) {
                        Image(viewModel.isCheckedPerformance ? .fullCheck : .emptyCheck)
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("공연에 대해 더 자세한 후기를 남길래요")
                            .font(.mainTextSemiBold18)
                            .foregroundStyle(viewModel.isCheckedPerformance ? .grayColorA : .grayColorG)
                        
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                if viewModel.isCheckedPerformance {
                    TextEditor(text: $viewModel.detailPerformanceReview)
                        .detailTextFieldModifier(height: 230, font: .mainTextMedium16
                        )
                }
            }
        }
    }
    
    // MARK: 다음 버튼
    private var nextBtn: some View {
        let enabled =  viewModel.isPerformanceStepValid
        
        return Button(action: {
            guard enabled else { return }
            dismiss()
        }) {
            MainRegistBtn(mainRegistType: .init(title: "완료"))
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
    RegistPerformanceReviewView()
        .environmentObject(DIContainer())
}
