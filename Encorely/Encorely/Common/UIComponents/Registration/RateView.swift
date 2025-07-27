//
//  RateView.swift
//  Encorely
//
//  Created by 이예지 on 7/25/25.
//

import SwiftUI

struct RateView: View {
    
    @Binding var currentStar: Int
    
    let starNumber: Int

    var filledImageName: String = "fillStar"
    var emptyImageName: String = "emptyStar"
    
    var spacing: CGFloat = 27

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<starNumber, id: \.self) { index in
                Image(currentStar > index ? filledImageName : emptyImageName)
                    .resizable()
                    .frame(width: 23, height: 21.9)
                    .onTapGesture {
                        currentStar = (currentStar == index + 1) ? 0 : index + 1
                    }
            }
        }
    }
}
