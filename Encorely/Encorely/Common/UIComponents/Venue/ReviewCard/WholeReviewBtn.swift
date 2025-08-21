//
//  WholeReviewBtn.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import SwiftUI

struct WholeReviewBtn: View {
    var body: some View {
        Button(action: {
        }) {
            Text("글 전문 보러가기")
                .foregroundStyle(.white)
                .font(.mainTextMedium18)
                .padding(.vertical, 19)
                .frame(width:320, height:45)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.mainColorB)
                }
        }
    
    }
}

#Preview {
    WholeReviewBtn()
}
