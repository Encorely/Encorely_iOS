//
//  SortingBtn.swift
//  Encorely
//
//  Created by 이민서 on 8/23/25.
//

import SwiftUI

struct SortingBtn: View {
    @State private var selectedOption = "인기순"
        let options = ["인기순", "최신순"]
        
        var body: some View {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                            .font(.mainTextMedium14)
                    }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(selectedOption)
                    Image(systemName: "chevron.down")
                }
                .font(.mainTextMedium14)
                .foregroundStyle(Color.black)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black, lineWidth: 1)
                )
                
            }
        }
}

#Preview {
    SortingBtn()
}
