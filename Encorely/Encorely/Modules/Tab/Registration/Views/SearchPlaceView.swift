//
//  SearchPlaceView.swift
//  Encorely
//
//  Created by 이예지 on 8/4/25.
//

import SwiftUI

struct SearchPlaceView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel = SubRegistViewModel()
    
    var body: some View {
        VStack(spacing: 25) {
            searchBar
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(0..<5) { index in
                        placeCard
                    }
                }
            }
        }
        .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading, content: {
                        Image(.chevronLeft)
                    })
                    
                    ToolbarItem(placement: .principal, content: {
                        Text("장소 첨부")
                            .font(.mainTextSemiBold20)
                    })
                })
    }
    
    private var searchBar: some View {
        HStack(spacing: 20) {
            TextField("장소명을 입력하세요.", text: $viewModel.searchPlace)
                .padding(.leading, 21)
                .font(.mainTextMedium14)
            
            Button(action: {
                
            }) {
                Image(.magnifyingGlass)
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.grayColorF)
                    .padding(.trailing, 25)
            }
        }
        .frame(height: 43)
        .background(Color.mainColorH)
        .clipShape(RoundedRectangle(cornerRadius: 100))
        .overlay {
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color.mainColorF, lineWidth: 1)
        }
        .padding(.horizontal, 32)
    }
    
    private var placeCard: some View {
        VStack(spacing: 16) {
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.gray.opacity(0.8))
            
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text("남월 안산한양대본점")
                        .foregroundStyle(.grayColorA)
                        .font(.mainTextMedium15)
                    
                    Text("경기도 안산시 상록구 성안길 81 101호")
                        .foregroundStyle(.grayColorF)
                        .font(.mainTextMedium11)
                }
                .padding(.leading, 11)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("첨부")
                        .frame(width: 48, height: 26)
                        .foregroundStyle(.grayColorA)
                        .font(.mainTextMedium11)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.mainColorH)
                        }
                }
                .padding(.trailing, 17)
            }
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.gray.opacity(0.8))
            
        }
        .padding(.horizontal, 9)
    }
}

#Preview {
    SearchPlaceView()
        .environmentObject(DIContainer())
}
