//
//  FacilityImageCard.swift
//  Encorely
//
//  Created by 이예지 on 7/25/25.
//

import SwiftUI

struct FacilityImageCard: View {
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.mainColorI)
                .frame(height: 122)
                .frame(maxWidth: .infinity)
            VStack(spacing: 7) {
                Image(.emptyPlus)
                Text("사진 첨부하기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(.grayScaleA)
            }
        }
    }
}

#Preview {
    FacilityImageCard()
}
