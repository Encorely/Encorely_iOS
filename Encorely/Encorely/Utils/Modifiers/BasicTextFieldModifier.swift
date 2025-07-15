//
//  BasicTextFieldModifier.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

// MARK: 기본 텍스트 필드에 사용
struct BasicTextFieldModifier: ViewModifier {
  
    var font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .textInputAutocapitalization(.never)
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func basicTextFieldModifier(font: Font) -> some View {
        modifier(BasicTextFieldModifier(font: font))
    }
}

/// 이렇게 쓰세용!
/// TextField("입력하기", text: $text)
///    .basicTextFieldModifier(font: .mainTextMedium18)
