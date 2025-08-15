//
//  ReviewUploadComplete.swift
//  Encorely
//
//  Created by 이예지 on 8/1/25.
//

import SwiftUI

struct ReviewUploadComplete: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Image("roundCheck")
                .resizable()
                .frame(width: 70, height: 70)
            
            uploadText
        }
        .padding(.bottom, 70)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: { dismiss() }) {
                    Image(.chevronLeft)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.grayColorA)
                }
            })
        })
    }
    
    private var uploadText: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("직관 후기 등록 완료!")
                .font(.mainTextSemiBold20)
            
            Text("이제 나의 후기를\n마이페이지에서 볼 수 있어요")
                .font(.mainTextMedium16)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ReviewUploadComplete()
}
