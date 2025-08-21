//
//  ReviewText.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import SwiftUI

struct ReviewText: View {
    let text: String
    private let limit = 80

    @Binding var isExpanded: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(textView)
                .font(.mainTextMedium16)
                .foregroundStyle(.grayColorC)
                .frame(width: 320, alignment: .leading)
                .animation(.easeInOut, value: isExpanded)

            Button(action: {
                isExpanded.toggle()
            }) {
                Text(isExpanded ? "접기" : "더보기")
                    .font(.mainTextMedium14)
                    .foregroundStyle(.grayColorE)
            }
        }
        .frame(width: 320, alignment: .leading)
    }
    
    private var textView: String {
            if isExpanded || text.count <= limit {
                return text
            } else {
                let index = text.index(text.startIndex, offsetBy: limit)
                return text[text.startIndex..<index] + "..."
            }
        }
}
