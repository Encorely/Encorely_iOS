//
//  UrlTextFieldModifier.swift
//  Encorely
//
//  Created by 이예지 on 7/25/25.
//

import SwiftUI

// MARK: URL을 삽입하는 텍스트 필드에 사용
struct UrlTextFieldModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.mainColorF, lineWidth: 1)
                    .frame(height: 40)
            }
            .font(.mainTextMedium14)
            .textInputAutocapitalization(.never)
            .frame(height: 40)
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func urlTextFieldModifier(
    ) -> some View {
        self.modifier(
            UrlTextFieldModifier()
        )
    }
}

/// 이렇게 쓰세용!
/// TextField("", text: $text)
///    .urlTextFieldModifier()
