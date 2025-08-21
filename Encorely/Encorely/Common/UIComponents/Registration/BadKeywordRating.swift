//
//  BadKeywordRating.swift
//  Encorely
//
//  Created by 이예지 on 7/24/25.
//

import SwiftUI

struct BadKeywordRating: View {
    
    @ObservedObject var viewModel: RegistViewModel
    let keywordType: KeywordType
    
    private var isSelected: Bool {
        viewModel.selectedBadKeywords.contains(keywordType.title)
    }
        
    var body: some View {
        Button(action: {
            viewModel.toggleBadKeyword(keywordType.title)
        }) {
            Text(keywordType.title)
                .padding(.horizontal, 21)
                .padding(.vertical, 9)
                .foregroundStyle(.grayColorA)
                .font(.mainTextMedium16)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(isSelected ? .subColorC : .grayColorI)
                        .strokeBorder(.subColorA, lineWidth:  isSelected ? 1 : 0)
                }
        }
    }
}
