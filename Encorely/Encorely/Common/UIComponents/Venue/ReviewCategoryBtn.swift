//
//  ReviewCategoryBtn.swift
//  Encorely
//
//  Created by 이민서 on 8/23/25.
//

import SwiftUI

struct reviewCategoryBtn: View {
    let reviewCategoryBtnType: reviewCategoryBtnType
    let action: () -> Void
    
    var body: some View {
        Button(action : action
            //TODO: - 연결
        ) {
            categoryInfo
        }
    }
    
    private var categoryInfo : some View {
        Text(reviewCategoryBtnType.categoryName)
            .font(.mainTextMedium18)
            .foregroundStyle(reviewCategoryBtnType.isSelected ? Color.white : Color.mainColorB)
            .frame(width: 113, height:42)
            .background(reviewCategoryBtnType.isSelected ? Color.mainColorC : Color.grayColorG)
            .clipShape(Capsule())
    }
}

#Preview {
    reviewCategoryBtn(
        reviewCategoryBtnType: reviewCategoryBtnType(categoryName:"카페", isSelected: true),
        action: {
            print("버튼 눌림")
        }
    )
}
