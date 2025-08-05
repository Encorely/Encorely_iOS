//
//  PurpleBorderTextFieldModifier.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

// MARK: 보라색 테두리를 가진 모든 텍스트 필드에 사용
struct PurpleBorderTextFieldModifier: ViewModifier {
    
    var height: CGFloat
    var font: Font
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.mainColorD, lineWidth: 1)
                    .frame(height: height)
            }
            .font(font)
            .textInputAutocapitalization(.never)
            .frame(height: height)
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func purpleBorderTextFieldModifier(
        height: CGFloat,
        font: Font
    ) -> some View {
        self.modifier(
            PurpleBorderTextFieldModifier(
                height: height,
                font: font
            )
        )
    }
}

/// 이렇게 쓰세용!
/// TextField("", text: $text)
///    .purpleBorderTextFieldModifier(height: 15, font: .mainTextMedium18)
