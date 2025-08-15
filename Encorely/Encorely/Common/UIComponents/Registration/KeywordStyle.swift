//
//  GoodKeywordRating.swift
//  Encorely
//
//  Created by 이예지 on 7/24/25.
//

import SwiftUI

struct KeywordStyle: View {
    
    let keywordType: KeywordType
    
    var body: some View {
        tagStyle
    }
    
    private var tagStyle: some View {
        Text(keywordType.title)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .foregroundStyle(.subColorB)
            .font(.mainTextMedium14)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.subColorH)
            }
    }
}
