//
//  MainReviewRegistView.swift
//  Encorely
//
//  Created by 이예지 on 7/22/25.
//

import SwiftUI
import PhotosUI

struct MainReviewRegistView: View {
    
    @EnvironmentObject var container: DIContainer
    @State private var tempSelectedDate: Date = Date()
    @State private var activeSheet: SheetType?
    @State private var showUploadComplete = false
    
    private var viewModel: RegistViewModel {
            container.registViewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.registrationBG
                    .ignoresSafeArea()
                
                VStack {
                    Text("후기 등록하기")
                        .font(.mainTextSemiBold20)
                        .foregroundStyle(Color.grayColorA)
                        .padding(.vertical, 7)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 55) {
                            topContents
                            MainMiddleContents(viewModel: viewModel)
                            bottomContents
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                    uploadBtn
                        .padding(.bottom, 10)
                }
            }
            .fullScreenCover(isPresented: $showUploadComplete) { ReviewUploadComplete()
            }
            
            .task(id: showUploadComplete) {
                guard showUploadComplete else { return }
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                viewModel.resetAll()
                activeSheet = nil
                container.navigationRouter.destination.removeAll()
                showUploadComplete = false
            }
            
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .calendar:
                    calendarSheet
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.fraction(0.5)])
                        .presentationCornerRadius(30)
                case .venueSeatRating:
                    RegistVenueView(showSheet: $activeSheet)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.fraction(0.65)])
                        .presentationCornerRadius(30)
                        .environmentObject(container)
                case .performanceReview:
                    RegistPerformanceReviewView()
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.fraction(0.65)])
                        .presentationCornerRadius(30)
                        .environmentObject(container)
                case .facility:
                    RegistFacilityView()
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.fraction(0.95)])
                        .presentationCornerRadius(30)
                        .environmentObject(container)
                }
            }
            .onChange(of: activeSheet) { oldValue, newValue in
                print("activeSheet 변경: \(String(describing: oldValue)) -> \(String(describing: newValue))")
            }
            .enableWindowTapToHideKeyboard()
        }
    }
    
    // MARK: 날짜, 회차, 공연명, 아티스트명
    private var topContents: some View {
        VStack(alignment: .leading, spacing: 27) {
            HStack(spacing: 15) {
                calendarBtn
                selectedRoundBtn
            }
            Text("공연에 대한 정보를 공유해보세요")
                .font(.mainTextSemiBold20)
            nameTextField
        }
    }
    
    // MARK: 달력 드롭다운 버튼
    private var calendarBtn: some View {
        VStack {
            Button (action: {
                activeSheet = .calendar
            }) {
                calendarBtnDetail
            }
        }
        .onAppear {
            if let existingDate = viewModel.selectedDate {
                tempSelectedDate = existingDate
            }
        }
    }
    
    // MARK: 달력 드롭다운 버튼 꾸밈 요소
    private var calendarBtnDetail: some View {
        HStack {
            Text(viewModel.displayDate)
            
            Spacer()
            
            Image("chevronDown")
        }
        .frame(width: 95)
        .basicDropdownModifier(horizontal: 15, vertical: 8)
    }
    
    // MARK: 달력 sheet
    private var calendarSheet: some View {
        DatePicker(
            "",
            selection: $tempSelectedDate,
            in: ...Date(), displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .onChange(of: tempSelectedDate) {
            viewModel.selectDate(tempSelectedDate)
        }
        .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    // MARK: 공연 회차 드롭다운 버튼
    private var selectedRoundBtn: some View {
        Menu {
            Button("1회차", action: { viewModel.selectRound("1회차")})
            Button("2회차", action: {
                viewModel.selectRound("2회차")})
            Button("3회차", action: {
                viewModel.selectRound("3회차")})
            Button("4회차", action: {
                viewModel.selectRound("4회차")})
            Button("5회차", action: {
                viewModel.selectRound("5회차")})
        } label: {
            selectedRoundBtnDetail
        }
        .buttonStyle(.plain)
    }
    
    // MARK: 공연 회차 드롭다운 버튼 꾸밈 요소
    private var selectedRoundBtnDetail: some View {
        HStack {
            Text(viewModel.displayRound)
            
            Spacer()
            
            Image("chevronDown")
        }
        .frame(width: 73)
        .basicDropdownModifier(horizontal: 15, vertical: 8)
    }
    
    // MARK: 공연명, 아티스트명 TextField
    private var nameTextField: some View {
        VStack(spacing: 17) {
            TextField("공연명을 입력해주세요", text: $container.registViewModel.performanceTitle)
                .titleTextFieldModifier(font: .mainTextMedium18)
            TextField("아티스트명을 입력해주세요", text: $container.registViewModel.artistName)
                .titleTextFieldModifier(font: .mainTextMedium18)
        }
    }
    
    // MARK: 리뷰 작성 버튼
    private var bottomContents: some View {
        VStack(spacing: 20) {
            Button (action: {
                container.navigationRouter.destination.removeAll()
                activeSheet = .venueSeatRating
            }) {
                DetailRegistrationBtn(detailRegistrationBtnType: .init(registTitle: "공연장/좌석등록/평가"))
            }
            
            Button (action: {
                activeSheet = .performanceReview
            }) {
                DetailRegistrationBtn(detailRegistrationBtnType: .init(registTitle: "공연 후기"))
            }
            
            Button (action: {
                activeSheet = .facility
            }) {
                DetailRegistrationBtn(detailRegistrationBtnType: .init(registTitle: "맛집/편의시설"))
            }
        }
    }
    
    // MARK: 업로드 버튼
    private var uploadBtn: some View {
        let enabled = viewModel.isUploadEnabled
        
        return Button(action: {
            guard enabled else { return }
            // TODO: 실제 업로드 트리거
            showUploadComplete = true
        }) {
            MainRegistBtn(mainRegistType: .init(title: "업로드"))
                .background (
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(enabled ? Color.mainColorB : Color.grayColorG)
                        .frame(height: 54)
                )
        }
        .disabled(!enabled)
        .padding(.horizontal, 16)
        .animation(.easeInOut(duration: 0.15), value: enabled)
    }
}

#Preview {
    MainReviewRegistView()
        .environmentObject(DIContainer())
    
}
