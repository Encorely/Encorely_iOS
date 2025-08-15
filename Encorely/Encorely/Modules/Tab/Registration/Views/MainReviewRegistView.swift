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
    @StateObject var viewModel = RegistViewModel()
    @State private var tempSelectedDate: Date = Date()
    @State private var activeSheet: SheetType?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.registrationBG
                    .ignoresSafeArea()
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 55) {
                            topContents
                            MainMiddleContents(viewModel: RegistViewModel())
                            bottomContents
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                    uploadBtn
                        .padding(.bottom, 10)
                }
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
                case .facility:
                    RegistFacilityView()
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.fraction(0.65)])
                        .presentationCornerRadius(30)
                }
            }
            .onChange(of: activeSheet) { oldValue, newValue in
                print("🔵 activeSheet 변경: \(String(describing: oldValue)) -> \(String(describing: newValue))")
                
                // sheet가 닫힐 때 navigation stack 정리
                if newValue == nil && oldValue == .venueSeatRating {
                    container.navigationRouter.destination.removeAll()
                    print("🔵 Sheet 닫힘 - Navigation stack 정리됨")
                }
            }
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
        .frame(width: 90)
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
            TextField("공연명을 입력해주세요", text: $viewModel.performanceTitle)
                .titleTextFieldModifier(font: .mainTextMedium18)
            TextField("아티스트명을 입력해주세요", text: $viewModel.artistName)
                .titleTextFieldModifier(font: .mainTextMedium18)
        }
    }
    
    // MARK: 리뷰 작성 버튼
    private var bottomContents: some View {
        VStack(spacing: 20) {
            Button (action: {
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
        Button(action: {
        }) {
            MainRegistBtn(mainRegistType: .init(title: "업로드"))
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    MainReviewRegistView()
        .environmentObject(DIContainer())
    
}
