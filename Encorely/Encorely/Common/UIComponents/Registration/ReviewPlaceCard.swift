//
//  ReviewPlaceCard.swift
//  Encorely
//
//  Created by 이예지 on 8/5/25.
//

import SwiftUI

struct ReviewPlaceCard: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 1) {
                Text("가천대학교 제2학생생활관")
                    .font(.mainTextMedium15)
                    .foregroundStyle(.grayColorA)
                
                Text("경기도 성남시 성남대로 1342")
                    .font(.mainTextMedium11)
                    .foregroundStyle(.grayColorF)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 47)
        .padding(.horizontal, 15)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.mainColorB, lineWidth: 1)
        }
    }
}

#Preview {
    ReviewPlaceCard()
}
