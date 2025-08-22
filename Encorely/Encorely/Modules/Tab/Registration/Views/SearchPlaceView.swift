//
//  SearchPlaceView.swift
//  Encorely
//
//  Created by 이예지 on 8/4/25.
//

import SwiftUI

struct SearchPlaceView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel = RegistViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State private var didSearch = false
    
    var body: some View {
        VStack(spacing: 16) {
            searchBar
                .padding(.bottom, 5)
            
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.grayColorH)
            
            placeList
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: {
                    dismiss()
                }) {
                    Image("chevronLeft")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.grayColorA)
                        .padding(.top, 30)
                }
            })
            
            ToolbarItem(placement: .principal, content: {
                Text("장소 첨부")
                    .font(.mainTextSemiBold20)
                    .padding(.top, 30)
            })
        })
        .navigationBarBackButtonHidden(true)
        .padding(.top, 20)
        .padding(.horizontal, 9)

    }
    
    private var searchBar: some View {
        HStack(spacing: 20) {
            TextField("장소명을 입력하세요.", text: $viewModel.searchPlace)
                .padding(.leading, 21)
                .font(.mainTextMedium14)
                .submitLabel(.search)
                .onSubmit {
                    let q = viewModel.searchPlace.trimmingCharacters(in: .whitespacesAndNewlines)
                    didSearch = !q.isEmpty
                }
                .onChange(of: viewModel.searchPlace) {
                    let q = viewModel.searchPlace.trimmingCharacters(in: .whitespacesAndNewlines)
                    if q.isEmpty { didSearch = false }
                }
            
            Button(action: {
                let q = viewModel.searchPlace.trimmingCharacters(in: .whitespacesAndNewlines)
                didSearch = !q.isEmpty
            }) {
                Image("magnifyingGlass")
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
        .padding(.horizontal, 15)
    }
    
    
    private var placeList: some View {
        ScrollView(showsIndicators: false) {
            if didSearch && !viewModel.searchPlace.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                LazyVStack(spacing: 16) {
                    ForEach(0..<5) { index in
                        placeCard
                    }
                }
            } else {
                emptyPlaceCard
            }
        }
    }
    
    private var emptyPlaceCard: some View {
        VStack(spacing: 25) {
            Image(systemName: "mappin.and.ellipse")
                .resizable()
                .frame(width: 58, height: 70)
                .foregroundStyle(Color.mainColorF.opacity(0.5))
            
            Text("장소명과 주소를 검색해보세요")
                .font(.mainTextRegular18)
        }
        .padding(.top, 180)
    }
    
    
    private var placeCard: some View {
        VStack(spacing: 16) {
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
                    // TODO: 장소 첨부하기
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
                .foregroundStyle(Color.grayColorH)
        }
    }
}

#Preview {
    SearchPlaceView()
        .environmentObject(DIContainer())
}
