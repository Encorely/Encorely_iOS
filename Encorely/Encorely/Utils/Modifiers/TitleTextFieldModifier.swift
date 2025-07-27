//
//  BasicTextFieldModifier.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

// MARK: 기본 텍스트 필드에 사용
struct TitleTextFieldModifier: ViewModifier {
  
    var font: Font
    
    func body(content: Content) -> some View {
        content
            .basicTextFieldModifier(font: .mainTextMedium18)
            .frame(height: 51)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            }
            .shadow(color: .grayScaleE, radius: 4)
            .multilineTextAlignment(.center)
            .font(font)
            .textInputAutocapitalization(.never)
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func titleTextFieldModifier(font: Font) -> some View {
        self.modifier(TitleTextFieldModifier(font: font))
    }
}

/// 이렇게 쓰세용!
/// TextField("입력하기", text: $text)
///    .basicTextFieldModifier(font: .mainTextMedium18)
