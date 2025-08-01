//
//  RegistProgress.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import SwiftUI

struct RegistProgress: View {
    
    let progressStep: Int
    let progressTitle = ["공연장", "좌석 등록", "좌석 평가"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<3, id: \.self) { index in
                self.progressElement(for: index)
            }
        }
        .padding(.top, 26)
    }
    
    private func progressElement(for index :Int) -> some View {
        let isCurrent = (index + 1 == progressStep)
        
        return VStack(spacing: 10) {
            Text(progressTitle[index])
                .font(.mainTextSemiBold20)
                .foregroundStyle(isCurrent ? .mainColorD : .grayColorF)
            
            Rectangle()
                .frame(width: 89, height: isCurrent ? 2 : 1)
                    .foregroundStyle(isCurrent ? .mainColorD : .grayColorI)
                    
        }
    }
}

#Preview {
    RegistProgress(progressStep: 1)
}
