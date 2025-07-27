//
//  TopTitleNaviBar.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import Foundation
import SwiftUI

/// 상단 타이틀 네비게이션 바
/// 좌측 뒤로가기 버튼, 중앙 타이틀
struct CustomToolBarModifier: ViewModifier {
    
    let title: String
    let leftChevron: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                // 뒤로가기 화살표 (왼쪽)
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: leftChevron) {
                        Image(.chevronLeft)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.grayScaleA)
                    }
                }
                
                // 타이틀 (가운데)
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.mainTextSemiBold20)
                        .foregroundStyle(.grayScaleA)
                }
            }
    }
}

extension View {
    
    /// 커스텀 네비게이션 툴바를 뷰에 적용하는 Modifier
    func customNavigation(
        title: String,
        leftChevron: @escaping () -> Void,
    ) -> some View {
        self.modifier(
            CustomToolBarModifier(
                title: title,
                leftChevron: leftChevron
            )
        )
    }
}

/// 이렇게 쓰세용!
/// .customNavigation(title: "", leftChevron: { container.navigationRouter.pop()} )
