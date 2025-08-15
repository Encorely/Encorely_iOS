//
//  RightSearchBar.swift
//  Encorely
//
//  Created by 이예지 on 7/18/25.
//

import SwiftUI

struct RightSearchBar: View {
    
    let rightSearchBarType: RightSearchBarType
    @State private var text = ""
    
    // MARK: 검색창 테두리
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .strokeBorder(Color.grayColorC, lineWidth: 1)
            .frame(height: 43)
            .overlay {
                searchElement
            }
    }
    
    // MARK: 검색창 요소(돋보기, 텍스트필드)
    private var searchElement: some View {
        HStack {
            TextField(rightSearchBarType.title, text: $text)
                .basicTextFieldModifier(font: .mainTextMedium14)
            
            Spacer()
            
            Image("magnifyingGlass")
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundStyle(.grayColorF)
                .padding(.leading, 20)
        }
        .padding(.horizontal, 25)
    }
}


#Preview {
    RightSearchBar(rightSearchBarType: .init(title: "공연명, 아티스트, 공연장 등을 입력해보세요"))
}
