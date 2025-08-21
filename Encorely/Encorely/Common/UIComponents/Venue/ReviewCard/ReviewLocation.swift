//
//  ReviewLocation.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import SwiftUI

struct ReviewLocation: View {
    var body: some View {
        HStack(spacing:8){
            Image(.location1)
                .foregroundStyle(Color.mainColorG)
                //.frame(width:14.17, height:17)
            Button(action: {}) {
                Text("위치 보러가기")
                    .font(.mainTextMedium14)
                    .foregroundColor(Color.grayColorC)
                    .underline()
            }
        }
    }
}

#Preview {
    ReviewLocation()
}
