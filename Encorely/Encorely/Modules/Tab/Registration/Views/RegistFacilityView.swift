//
//  RegistFacilityView.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI
import PhotosUI

struct RegistFacilityView: View {
    
    @EnvironmentObject var container: DIContainer
    @Environment(\.dismiss) private var dismiss
    
    let keywordList = KeywordType.RestaurantTag
    
    private var viewModel: RegistViewModel {
            container.registViewModel
    }
    
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
                    Button("밥집") { container.registViewModel.selectRestaurant(.restaurant) }
                    Button("카페") { container.registViewModel.selectRestaurant(.cafe) }
                    Button("술집") { container.registViewModel.selectRestaurant(.bar) }
                } label: {
                    selectedRestaurantBtnDetail(viewModel: container.registViewModel)
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
        .padding(.top, 20)
    }
    
    private struct selectedRestaurantBtnDetail: View {
        @ObservedObject var viewModel: RegistViewModel
        
        var body: some View {
            HStack {
                Text(viewModel.displayRestaurant)
                    .foregroundStyle(.grayColorF)
                    .font(.mainTextMedium16)
                
                Spacer()
                
                Image("chevronDown")
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
                    .strokeBorder(.mainColorF, lineWidth: 1)
            }
        }
    }
    
    /// 장소 첨부, 사진 첨부
    private var middleContentsR: some View {
        VStack(spacing: 20) {
            Button(action: {
                
            }, label: {
                facilityMapButton()
            })
            
            PhotosPicker(
                selection: $container.registViewModel.restaurantItem,
                matching: .images
            ) {
                if container.registViewModel.restaurantItem == nil {
                    noneImageView
                } else {
                    restaurantImageCard
                }
            }
            .onChange(of: container.registViewModel.restaurantItem) {
                container.registViewModel.loadRestaurantImage()
            }
        }
    }
    
    /// 맛집 사진이 삽입된 상태일 때
    private var restaurantImageCard: some View {
        Image(uiImage: container.registViewModel.restaurantImage ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 122)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
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
                                GoodKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: keywordList[index]
                                )
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(3...5, id: \.self) { index in
                                GoodKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: keywordList[index]
                                )
                            }
                        }
                        
                        HStack(spacing: 15) {
                            ForEach(6...9, id: \.self) { index in
                                GoodKeywordRating(
                                    viewModel: container.registViewModel,
                                    keywordType: keywordList[index]
                                )
                            }
                        }
                        
                    }
                }
            }
            restaurantDetailToggleView(viewModel: container.registViewModel)
        }
    }
    
    private struct restaurantDetailToggleView: View {
        @ObservedObject var viewModel: RegistViewModel
        
        var body: some View {
            VStack(spacing: 23) {
                Button(action: {
                    viewModel.isCheckedRestaurant.toggle()
                }) {
                    HStack(spacing: 15) {
                        Image(viewModel.isCheckedRestaurant ? .fullCheck : .emptyCheck)
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("맛집에 대해 더 자세한 후기를 남길래요")
                            .font(.mainTextSemiBold18)
                            .foregroundStyle(viewModel.isCheckedRestaurant ? .grayColorA : .grayColorG)
                        
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                if viewModel.isCheckedRestaurant {
                    TextEditor(text: $viewModel.detailRestaurantReview)
                        .detailTextFieldModifier(height: 100, font: .mainTextMedium16
                        )
                }
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
                    Button("화장실") { container.registViewModel.selectFacility(.restroom) }
                    Button("편의점") { container.registViewModel.selectFacility(.convenienceStore) }
                    Button("주차장") { container.registViewModel.selectFacility(.parking) }
                    Button("벤치")  { container.registViewModel.selectFacility(.bench) }
                    Button("ATM")  { container.registViewModel.selectFacility(.atm) }
                    Button("기타")  { container.registViewModel.selectFacility(.other) }
                } label: {
                    selectedFacilityBtnDetail(viewModel: container.registViewModel)
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
        }
        .padding(.top, 20)
    }
    
    private struct selectedFacilityBtnDetail: View {
        @ObservedObject var viewModel: RegistViewModel
        var body: some View {
            HStack {
                Text(viewModel.displayFacility)
                    .foregroundStyle(.grayColorF)
                    .font(.mainTextMedium16)
                
                Spacer()
                
                Image("chevronDown")
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
                    .strokeBorder(.mainColorF, lineWidth: 1)
            }
        }
    }
    
    /// 장소 첨부, 사진 첨부
    private var middleContentsF: some View {
        VStack(spacing: 20) {
            Button(action: {
                
            }, label: {
                facilityMapButton()
            })
            
            PhotosPicker(
                selection: $container.registViewModel.facilityItem,
                matching: .images
            ) {
                if container.registViewModel.facilityItem == nil {
                    noneImageView
                } else {
                    facilityImageCard
                }
            }
            .onChange(of: container.registViewModel.restaurantItem) {
                container.registViewModel.loadRestaurantImage()
            }
        }
    }
    
    /// 편의시설 사진이 삽입된 상태일 때
    private var facilityImageCard: some View {
        Image(uiImage: container.registViewModel.facilityImage ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 122)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    /// 자세한 후기
    private var bottomContentsF: some View {
        facilityDetailToggleView(viewModel: container.registViewModel)
    }
    
    private struct facilityDetailToggleView: View {
        @ObservedObject var viewModel: RegistViewModel
        
        var body: some View {
            VStack(spacing: 23) {
                Button(action: {
                    viewModel.isCheckedFacility.toggle()
                }) {
                    HStack(spacing: 15) {
                        Image(viewModel.isCheckedFacility ? .fullCheck : .emptyCheck)
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("편의시설에 대해 더 자세한 후기를 남길래요")
                            .font(.mainTextSemiBold18)
                            .foregroundStyle(viewModel.isCheckedFacility ? .grayColorA : .grayColorG)
                        
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                if viewModel.isCheckedFacility {
                    TextEditor(text: $viewModel.detailFacilityReview)
                        .detailTextFieldModifier(height: 100, font: .mainTextMedium16
                        )
                }
            }
        }
    }
    
    
    // MARK: 사진이 비어있을 때
    private var noneImageView: some View {
        FacilityImageCard()
    }
    
    
    // MARK: 다음 버튼
    private var nextBtn: some View {
        Button(action: {
            dismiss()
        }) {
            MainRegistBtn(mainRegistType: .init(title: "완료"))
                .background (
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.mainColorB)
                        .frame(height: 54)
                )
        }
    }
}

#Preview {
    RegistFacilityView()
        .environmentObject(DIContainer())
}
