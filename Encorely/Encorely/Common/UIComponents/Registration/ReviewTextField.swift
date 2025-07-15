//
//  ReviewTextField.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

/// 후기 작성창 텍스트필드(공연명, 아티스트명)
struct ReviewTextField: View {
    
    @State private var text = ""
    let reviewTextFieldType: ReviewTextFieldType
        
    var body: some View {
        TextField(
            reviewTextFieldType.promptText,
            text : $text,
        )
        .basicTextFieldModifier(font: .mainTextMedium18)
        .frame(height: 51)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
        }
        .shadow(color: .grayScaleE, radius: 3)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    ReviewTextField(reviewTextFieldType: .init(promptText: "공연명을 입력해주세요"))
}
