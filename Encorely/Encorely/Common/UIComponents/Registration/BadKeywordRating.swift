//
//  BadKeywordRating.swift
//  Encorely
//
//  Created by 이예지 on 7/24/25.
//

import SwiftUI

struct BadKeywordRating: View {
    
    @State private var isSelected: Bool = false
        
    var body: some View {
        tagStyle
    }
    
    private var tagStyle: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            Text("너무 멀어요")
                .padding(.horizontal, 21)
                .padding(.vertical, 9)
                .foregroundStyle(.grayScaleA)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(isSelected ? .subColorC : .grayScaleM)
                        .stroke(.subColorD, lineWidth:  isSelected ? 1 : 0)
                }
        }
    }
}

#Preview {
    BadKeywordRating()
}
