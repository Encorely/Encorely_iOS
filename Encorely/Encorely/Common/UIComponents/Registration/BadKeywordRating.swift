//
//  BadKeywordRating.swift
//  Encorely
//
//  Created by 이예지 on 7/24/25.
//

import SwiftUI

struct BadKeywordRating: View {
    
    @State private var isSelected: Bool = false
    
    let keywordType: KeywordType
        
    var body: some View {
        tagStyle
    }
    
    private var tagStyle: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            Text(keywordType.title)
                .padding(.horizontal, 21)
                .padding(.vertical, 9)
                .foregroundStyle(.grayColorA)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(isSelected ? .subColorC : .grayColorI)
                        .stroke(.subColorA, lineWidth:  isSelected ? 1 : 0)
                }
        }
    }
}
