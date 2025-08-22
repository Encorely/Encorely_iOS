//
//  facilityMapButton.swift
//  Encorely
//
//  Created by 이예지 on 8/2/25.
//

import SwiftUI

struct facilityMapButton: View {
    var body: some View {
        ZStack {
            Image("mapButton")
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 47)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("장소 추가하기")
                .font(.mainTextMedium16)
                .foregroundStyle(.grayColorA)
        }
    }
}

#Preview {
    facilityMapButton()
}
