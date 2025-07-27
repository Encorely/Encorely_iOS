//
//  DetailRegistrationBtn.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

/// 후기작성창(공연장/좌석등록/평가, 공연 후기, 맛집/편의시설) 버튼
struct DetailRegistrationBtn: View {
    
    let detailRegistrationBtnType: DetailRegistrationBtnType
    
    // MARK: 둥근모서리사각형 전체 버튼화
    var body: some View {
        HStack {
            Text(detailRegistrationBtnType.registTitle)
                .font(.mainTextMedium18)
                .foregroundStyle(.grayScaleA)
                .padding(.leading, 30)
            Spacer()
            Image(.chevronRight)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.grayScaleA)
                .padding(.trailing, 7)
        }
        .frame(height: 58)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
        }
        .shadow(color: .grayScaleE, radius: 4)
    }
}

#Preview {
    DetailRegistrationBtn(detailRegistrationBtnType: .init(registTitle: "공연장/좌석등록/평가"))
}
