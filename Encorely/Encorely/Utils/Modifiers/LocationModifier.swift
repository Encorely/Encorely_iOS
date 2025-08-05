//
//  LocationModifier.swift
//  Encorely
//
//  Created by 이예지 on 8/1/25.
//

import SwiftUI

// MARK: 후기 전문 장소 이름
struct LocationModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.grayColorF)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.mainColorH)
                    .strokeBorder(.mainColorF, lineWidth: 1)
            }
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func locationModifier(
    ) -> some View {
        self.modifier(
            LocationModifier()
        )
    }
}

/// 이렇게 쓰세용!
/// Text(text)
///    .locationModifier( )
