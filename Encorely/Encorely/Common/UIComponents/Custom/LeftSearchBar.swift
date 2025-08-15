//
//  LeftSearchBar.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

/// 왼쪽에 돋보기가 있는 검색창
struct LeftSearchBar: View {
    
    let leftSearchBarType: LeftSearchBarType
    @State private var text = ""
 
    // MARK: 검색창 테두리
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .strokeBorder(Color.grayColorC, lineWidth: 1)
            .frame(height: 49)
            .overlay {
                searchElement
            }
    }
    
    // MARK: 검색창 요소(돋보기, 텍스트필드)
    private var searchElement: some View {
        HStack(spacing: 13) {
            Image("magnifyingGlass")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(.grayColorA)

            TextField(leftSearchBarType.title, text: $text)
                .basicTextFieldModifier(font: .mainTextMedium16)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    LeftSearchBar(leftSearchBarType: .init(title: "내가 찾고 싶은 공연장을 검색하세요"))
}
