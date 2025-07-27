//
//  MainReviewRegistView.swift
//  Encorely
//
//  Created by 이예지 on 7/22/25.
//

import SwiftUI

struct MainReviewRegistView: View {
    
    @StateObject var viewModel = MainReviewRegistViewModel()
    @State private var tempSelectedDate: Date = Date()
    @EnvironmentObject var container: DIContainer
    @State private var activeSheet: SheetType?
    @State private var performanceTitle = ""
    @State private var artistName = ""
    
    var body: some View {
            ZStack {
                Color.registrationBG
                    .ignoresSafeArea()
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 55) {
                            topContents
                            middleContents
                            bottomContents
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 16)
                    uploadBtn
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
                        .presentationDetents([.fraction(0.65)])
                        .presentationCornerRadius(30)
                case .performanceReview:
                    RegistPerformanceReviewView()
                        .presentationDetents([.fraction(0.65)])
                        .presentationCornerRadius(30)
                case .facility:
                    RegistFacilityView()
                        .presentationDetents([.fraction(0.65)])
                        .presentationCornerRadius(30)
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
                .foregroundStyle(.grayScaleK)
                .font(.mainTextMedium14)
            
            Spacer()
            
            Image(.chevronDown)
                .foregroundStyle(.grayScaleJ)
        }
        .padding(.horizontal, 15)
        .frame(width: 120, height: 33)
        .background {
            RoundedRectangle(cornerRadius: 100)
                .fill(.grayScaleG)
                .stroke(.grayScaleJ, lineWidth: 1)
        }
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
                .foregroundStyle(.grayScaleK)
                .font(.mainTextMedium14)
            
            Spacer()
            
            Image(.chevronDown)
                .foregroundStyle(.grayScaleJ)
        }
        .padding(.leading, 15)
        .padding(.trailing, 12)
        .frame(width: 99, height: 33)
        .background {
            RoundedRectangle(cornerRadius: 100)
                .fill(.grayScaleG)
                .stroke(.grayScaleJ, lineWidth: 1)
        }
    }
    
    // MARK: 공연명, 아티스트명 TextField
    private var nameTextField: some View {
        VStack(spacing: 17) {
            TextField("공연명을 입력해주세요", text: $performanceTitle)
                .titleTextFieldModifier(font: .mainTextMedium18)
            TextField("아티스트명을 입력해주세요", text: $artistName)
                .titleTextFieldModifier(font: .mainTextMedium18)
        }
    }
    
    // MARK: 시야사진, 공연사진
    private var middleContents: some View {
        ZStack {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 225, height: 310)
                    .foregroundStyle(.white)
                    .shadow(color: .grayScaleE, radius: 4)
                ZStack {
                    Image(.empty)
                        .resizable()
                        .frame(width: 191, height: 260)
                    
                    Text("공연장 사진을\n올려주세요")
                        .font(.mainTextSemiBold20)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .offset(y: 15)
            }
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Image(.emptyPlus)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .padding(.trailing, 8)
            }
        }
    }
    
    // MARK: 사진 카테고리 드롭다운
    private var photoCategoryDropDown: some View {
        Menu {
            Button("시야사진", action: {
                viewModel.selectedImageCategory("시야사진")})
            Button("공연사진", action: {
                viewModel.selectedImageCategory("공연사진")})
        } label: {
            selectedRoundBtnDetail
        }
    }
    
    // MARK: 시야사진
    private var sightImageView: some View {
        Text("시야사진")
    }
    
    // MARK: 공연사진
    private var performanceImageView: some View {
        Text("공연사진")
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
}
