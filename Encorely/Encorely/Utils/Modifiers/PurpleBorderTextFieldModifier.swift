//
//  PurpleBorderTextFieldModifier.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

// MARK: 보라색 테두리를 가진 모든 텍스트 필드에 사용
struct PurpleBorderTextFieldModifier: ViewModifier {
    
    var width: CGFloat
    var height: CGFloat
    var font: Font
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.mainColorF, lineWidth: 1)
                    .frame(width: width, height: height)
            }
            .font(font)
            .textInputAutocapitalization(.never)
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func purpleBorderTextFieldModifier(width: CGFloat, height: CGFloat, font: Font) -> some View {
        modifier(PurpleBorderTextFieldModifier(width: width, height: height, font: font))
    }
}

/// 이렇게 쓰세용!
/// TextField("", text: $text)
///    .purpleBorderTextFieldModifier(width: 40, height: 15, font: .mainTextMedium18)
