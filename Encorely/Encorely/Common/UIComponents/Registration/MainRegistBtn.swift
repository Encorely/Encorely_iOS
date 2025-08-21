//
//  MainRegistBtn.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import SwiftUI

/// 후기작성창 메인버튼(다음 후기 작성 단계로 넘어가기, 후기 업로드 하기)
struct MainRegistBtn: View {
    
    let mainRegistType: MainRegistType
    
    var body: some View {
        Text(mainRegistType.title)
            .foregroundStyle(.grayColorJ)
            .font(.mainTextSemiBold20)
            .padding(.vertical, 19)
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainRegistBtn(mainRegistType: .init(title: "업로드"))
}
