//
//  PerformanceInfoModifier.swift
//  Encorely
//
//  Created by 이예지 on 8/1/25.
//

import SwiftUI

// MARK: 후기 전문 공연일, 공연회차 외곽선
struct PerformanceInfoModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .font(.mainTextMedium14)
            .foregroundStyle(.grayColorA)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.grayColorJ)
                    .strokeBorder(Color.grayColorC, lineWidth: 1)
            }
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func performanceInfoModifier(
    ) -> some View {
        self.modifier(
            PerformanceInfoModifier()
        )
    }
}

/// 이렇게 쓰세용!
/// Text(text)
///    .performanceInfoModifier()
