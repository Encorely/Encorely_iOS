//
//  RegistFacilityView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

struct RegistFacilityView: View {
    
    @StateObject var viewModel = SubRegistViewModel()
    
    let keywordList = KeywordType.RestaurantTag
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            topTitle
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    restaurantContents
                    
                    facilityContents
                }
                .padding(.bottom, 16)
            }
            .padding(.bottom, 16)
            nextBtn
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: 상단 타이틀 (맛집 및 편의시설)
    private var topTitle: some View {
        HStack {
            VStack(spacing: 10) {
                Text("맛집 및 편의시설")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.mainColorD)
                
                Rectangle()
                    .frame(width: 147, height: 2)
                    .foregroundStyle(.mainColorD)
            }
            
            Spacer()
        }
        .padding(.top, 26)
    }
    
    
    // MARK: 맛집 후기 남는 view
    private var restaurantContents: some View {
        VStack(spacing: 20) {
            topContentsR
            
            middleContentsR
            
            bottomContentsR
        }
    }
    
    /// 타이틀, 서브타이틀, 드롭다운
    private var topContentsR: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("맛집")
                    .font(.mainTextSemiBold18)
                
                Text("다녀온 맛집을 남겨주세요!")
                    .font(.mainTextMedium14)
                    .padding(.bottom, 7)
                
                Menu {
                    Button("밥집", action: {
                        viewModel.selectedRestaurant = "밥집"
                    })
                    Button("카페", action: {
                        viewModel.selectedRestaurant = "카페"
                    })
                    Button("술집", action: {
                        viewModel.selectedRestaurant = "술집"
                    })
                } label: {
                    selectedRestaurantBtnDetail
                }
                .buttonStyle(.plain)
                .padding(.leading, 1)
            }
            
            Spacer()
        }
        .padding(.top, 20)
    }
    
    private var selectedRestaurantBtnDetail: some View {
        HStack {
            
            Text(viewModel.displayRestaurant)
                .foregroundStyle(.grayColorF)
                .font(.mainTextMedium16)
            
            Spacer()
            
            Image(.chevronDown)
                .resizable()
                .frame(width: 16, height: 9.04)
                .foregroundStyle(.grayColorD)
        }
        .padding(.leading, 20)
        .padding(.trailing, 18)
        .frame(width: 103, height: 33)
        .background {
            RoundedRectangle(cornerRadius: 100)
                .fill(.mainColorH)
                .stroke(.mainColorF, lineWidth: 1)
        }
    }
    
    /// 장소 첨부, 사진 첨부
    private var middleContentsR: some View {
        VStack(spacing: 20) {
            TextField("맛집 장소의 링크를 첨부해주세요!", value: $viewModel.restaurantURL, format: .url)
                .padding(.horizontal, 18)
                .urlTextFieldModifier()
                .padding(.horizontal, 1)
            
            Button(action: {
                
            }, label: {
                FacilityImageCard()
            })
        }
    }
    
    /// 키워드 평가, 자세한 후기
    private var bottomContentsR: some View {
        VStack(spacing: 23) {
            VStack(alignment: .leading, spacing: 20) {
                Text("이런 점이 좋아요")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(.grayColorA)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        HStack(spacing: 15) {
                            ForEach(0...2, id: \.self) { index in
                                GoodKeywordRating(keywordType: keywordList[index])
                            }
                        }
                        .padding(1)
                        
                        HStack(spacing: 15) {
                            ForEach(3...5, id: \.self) { index in
                                GoodKeywordRating(keywordType: keywordList[index])
                            }
                        }
                        .padding(1)
                        
                        HStack(spacing: 15) {
                            ForEach(6...9, id: \.self) { index in
                                GoodKeywordRating(keywordType: keywordList[index])
                            }
                        }
                        .padding(1)
                        
                    }
                }
            }
            
            HStack(spacing: 15) {
                
                Button(action: {
                    viewModel.isCheckedRestaurant.toggle()
                }) {
                    Image(viewModel.isCheckedRestaurant ? .fullCheck : .emptyCheck)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                Text("맛집에 대해 더 자세한 후기를 남길래요")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(viewModel.isCheckedRestaurant ? .grayColorA : .grayColorG)
                
                Spacer()
            }
            if viewModel.isCheckedRestaurant {
                TextEditor(text: $viewModel.detailRestaurantReview)
                    .detailTextFieldModifier(height: 100, font: .mainTextMedium16
                    )
            }
        }
    }
    
    
    // MARK: 편의시설 후기 남기는 view
    private var facilityContents: some View {
        VStack(spacing: 20) {
            topContentsF
            middleContentsF
            bottomContentsF
        }
    }

    /// 타이틀, 서브타이틀, 드롭다운
    private var topContentsF: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("편의시설")
                    .font(.mainTextSemiBold18)
                
                Text("더 편리한 공연 생활을 위한 꿀팁을 남겨주세요!")
                    .font(.mainTextMedium14)
                    .padding(.bottom, 7)
                
                Menu {
                    Button("화장실", action: {
                        viewModel.selectedFacility = "화장실"
                    })
                    Button("편의점", action: {
                        viewModel.selectedFacility = "편의점"
                    })
                    Button("주차장", action: {
                        viewModel.selectedFacility = "주차장"
                    })
                    Button("벤치", action: {
                        viewModel.selectedFacility = "벤치"
                    })
                    Button("ATM", action: {
                        viewModel.selectedFacility = "ATM"
                    })
                    Button("기타", action: {
                        viewModel.selectedFacility = "기타"
                    })
                } label: {
                    selectedFacilityBtnDetail
                }
                .buttonStyle(.plain)
                .padding(.leading, 1)
            }
            
            Spacer()
        }
        .padding(.top, 20)
    }
    
    private var selectedFacilityBtnDetail: some View {
        HStack {
            
            Text(viewModel.displayFacility)
                .foregroundStyle(.grayColorF)
                .font(.mainTextMedium16)
            
            Spacer()
            
            Image(.chevronDown)
                .resizable()
                .frame(width: 16, height: 9.04)
                .foregroundStyle(.grayColorD)
        }
        .padding(.leading, 18)
        .padding(.trailing, 18)
        .frame(width: 103, height: 33)
        .background {
            RoundedRectangle(cornerRadius: 100)
                .fill(.mainColorH)
                .stroke(.mainColorF, lineWidth: 1)
        }
    }
    
    /// 장소 첨부, 사진 첨부
    private var middleContentsF: some View {
        VStack(spacing: 20) {
            TextField("편의시설 장소의 링크를 첨부해주세요!", value: $viewModel.facilityURL, format: .url)
                .padding(.horizontal, 18)
                .urlTextFieldModifier()
                .padding(.horizontal, 1)
            
            Button(action: {
                
            }, label: {
                FacilityImageCard()
            })
        }
    }
    
    /// 자세한 후기
    private var bottomContentsF: some View {
        VStack(spacing: 23) {
            HStack(spacing: 15) {
                Button(action: {
                    viewModel.isCheckedFacility.toggle()
                }) {
                    Image(viewModel.isCheckedFacility ? .fullCheck : .emptyCheck)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text("편의시설에 대해 더 자세한 후기를 남길래요")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(viewModel.isCheckedFacility ? .grayColorA : .grayColorG)
                Spacer()
            }
            if viewModel.isCheckedFacility {
                TextEditor(text: $viewModel.detailFacilityReview)
                    .detailTextFieldModifier(height: 100, font: .mainTextMedium16
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
    RegistFacilityView()
}
