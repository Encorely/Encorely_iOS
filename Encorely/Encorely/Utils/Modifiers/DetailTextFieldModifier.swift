//
//  DetailTextFieldModifier.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

// MARK: 자세한 후기 남기는 텍스트에디터에 사용
struct DetailTextFieldModifier: ViewModifier {
    
    var height: CGFloat
    var font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .textInputAutocapitalization(.never)
            .scrollContentBackground(.hidden)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.grayColorI)
            }
    }
}

// MARK: 수정자로 간단하게 사용!
extension View {
    func detailTextFieldModifier(
        height: CGFloat,
        font: Font
    ) -> some View {
        self.modifier(
            DetailTextFieldModifier(
                height: height,
                font: font
            )
        )
    }
}

/// 이렇게 쓰세용!
/// TextField("", text: $text)
///    .detailTextFieldModifier(height: 15, font: .mainTextMedium18)
