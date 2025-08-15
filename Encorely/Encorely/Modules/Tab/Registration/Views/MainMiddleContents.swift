//
//  MainMiddleContents.swift
//  Encorely
//
//  Created by 이예지 on 8/4/25.
//

import SwiftUI
import PhotosUI

struct MainMiddleContents: View {
    
    @ObservedObject var viewModel: RegistViewModel
    
    @State private var sightCurrentPage: Int = 0
    @State private var performanceCurrentPage: Int = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 225, height: 310)
                .foregroundStyle(.grayColorJ)
                .shadow(color: .grayColorH, radius: 3)
            
            if viewModel.selectedImageCategory == .sight {
                sightImageView
                    .offset(y: 15)
            } else {
                performanceImageView
                    .offset(y: 15)
            }
            
            photoCategoryDropDown
                .offset(x: 29, y: 30)
            
        }
        .onChange(of: viewModel.sightItems) { _, _ in
                viewModel.loadSightImages()
            }
        .onChange(of: viewModel.performanceItems) { _, _ in
            viewModel.loadPerformanceImages()
        }
    }
    
    // MARK: 사진 카테고리 드롭다운
    private var photoCategoryDropDown: some View {
        Menu {
            Button("시야사진", action: {
                viewModel.selectedImageCategory(.sight)
            })
            Button("공연사진", action: {
                viewModel.selectedImageCategory(.performance)
            })
        } label: {
            selectedImageCategoryBtnDetail
        }
    }
    
    // MARK: 공연 회차 드롭다운 버튼 꾸밈 요소
    private var selectedImageCategoryBtnDetail: some View {
        HStack {
            Text(viewModel.displayImageCategory)
            
            Spacer()
            
            Image("chevronDown")
        }
        .frame(width: 73)
        .basicDropdownModifier(horizontal: 15, vertical: 8)
    }
    
    // MARK: 사진이 비어있을 때
    private var noneImageView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.grayColorF.opacity(0.6), style: StrokeStyle(lineWidth: 1, lineCap: .square, dash: [5]))
                .frame(width: 191, height: 260)
                .background(.clear)
            
            Text("공연장 사진을\n올려주세요")
                .font(.mainTextSemiBold20)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
    }
    
    // MARK: 시야사진
    private var sightImageView: some View {
        ZStack {
            if viewModel.sightItems.isEmpty {
                noneImageView
            } else {
                sightPageControl
            }
            
            HStack {
                Spacer()
                PhotosPicker(
                    selection: $viewModel.sightItems,
                    maxSelectionCount: 5,
                    matching: .images
                ) {
                    Image("emptyPlus")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 8)
                }
            }
        }
    }
    
    // MARK: 시야사진 PageControl
    private var sightPageControl: some View {
            TabView(selection: $sightCurrentPage) {
                ForEach(0..<viewModel.sightImages.count, id: \.self) { index in
                    Image(uiImage: viewModel.sightImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 191, height: 260)
                        .clipped()
                        .cornerRadius(10)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(width: 191, height: 260)
            .onChange(of: sightCurrentPage) { _, newValue in
                viewModel.currentPage = newValue
            }
        }
    
    // MARK: 공연사진
    private var performanceImageView: some View {
        ZStack {
            if viewModel.performanceItems.isEmpty {
                noneImageView
            } else {
                performancePageControl
            }
            
            HStack {
                Spacer()
                PhotosPicker(
                    selection: $viewModel.performanceItems,
                    maxSelectionCount: 5,
                    matching: .images
                ) {
                    Image("emptyPlus")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 8)
                }
            }
        }
    }
    
    // MARK: 공연사진 PageControl
    private var performancePageControl: some View {
        TabView(selection: $performanceCurrentPage) {
                    ForEach(0..<viewModel.performanceImages.count, id: \.self) { index in
                        Image(uiImage: viewModel.performanceImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 191, height: 260)
                            .clipped()
                            .cornerRadius(10)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(width: 191, height: 260)
                .onChange(of: performanceCurrentPage) { _, newValue in
                    viewModel.currentPage = newValue
                }
    }
    
}

#Preview {
    MainMiddleContents(viewModel: RegistViewModel())
}
