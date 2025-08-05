//
//  PurpleRoundedRectangleModifier.swift
//  Encorely
//
//  Created by 이예지 on 8/1/25.
//

import SwiftUI

// MARK: 후기 전문 공연일, 공연회차 외곽선
struct PurpleRoundedRectangleModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .font(.mainTextMedium16)
            .foregroundStyle(.grayColorJ)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.mainColorB)
            }
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func purpleRoundedRectangleModifier(
    ) -> some View {
        self.modifier(
            PurpleRoundedRectangleModifier()
        )
    }
}

/// 이렇게 쓰세용!
/// Text(text)
///    .purpleRoundedRectangleModifier( )
