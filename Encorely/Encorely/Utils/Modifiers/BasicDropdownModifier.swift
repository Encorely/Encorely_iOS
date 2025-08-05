//
//  BasicDropdownModifier.swift
//  Encorely
//
//  Created by 이예지 on 8/1/25.
//

import SwiftUI

// MARK: 후기 전문 공연일, 공연회차 외곽선
struct BasicDropdownModifier: ViewModifier {
    
    var horizontal: CGFloat
    var vertical: CGFloat
        
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.grayColorA)
            .font(.mainTextMedium14)
            .padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.grayColorJ)
                    .strokeBorder(.grayColorC, lineWidth: 1)
            }
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func basicDropdownModifier(
        horizontal: CGFloat,
        vertical: CGFloat
    ) -> some View {
        self.modifier(
            BasicDropdownModifier(
                horizontal: horizontal,
                vertical: vertical
            )
        )
    }
}

/// 이렇게 쓰세용!
/// Text(text)
///    .basicDropdownModifier(horizontal: 15, vertical: 8)
