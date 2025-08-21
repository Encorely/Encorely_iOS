//
//  ReviewRatingTags.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import SwiftUI

struct ReviewRatingTags: View {
    let tags: [String]
    let isExpanded: Bool  /// 상위에서 내려주는 확장 여부
    @Binding var showAllTags: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                ForEach(firstLineTags, id: \.self) { tag in
                    tagView(text: tag)
                }

                /// 조건: 더보기 안 눌린 경우 &  +N 버튼도 아직 안 눌린 경우
                if !isExpanded && !showAllTags && hiddenCount > 0 {
                    Button("+\(hiddenCount)") {
                        withAnimation {
                            showAllTags = true
                        }
                    }
                    .font(.mainTextMedium14)
                    .foregroundStyle(.subColorB)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.subColorH)
                    .clipShape(Capsule())
                }
            }

            /// 조건: 더보기 눌렀거나 +N 눌렸을 때만
            if isExpanded || showAllTags {
                ForEach(remainingLines, id: \.self) { rowTags in
                    HStack(spacing: 8) {
                        ForEach(rowTags, id: \.self) { tag in
                            tagView(text: tag)
                        }
                    }
                }
            }
        }
    }

    private var hiddenCount: Int {
        max(tags.count - 2, 0)
    }

    private var firstLineTags: [String] {
        Array(tags.prefix(2))
    }

    private var remainingTags: [String] {
        Array(tags.dropFirst(2))
    }

    private var remainingLines: [[String]] {
        stride(from: 0, to: remainingTags.count, by: 2).map { start in
            let end = min(start + 2, remainingTags.count)
            return Array(remainingTags[start..<end])
        }
    }

    private func tagView(text: String) -> some View {
        Text(text)
            .font(.mainTextMedium14)
            .foregroundStyle(.subColorB)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            //.frame(height: 24)
            .background(Color.subColorH)
            .clipShape(Capsule())
    }
}

#Preview {
    ReviewRatingTags(
        tags: ["돌출이 가까워요", "사진보다 잘 보여요", "토롯코 잘 보여요", "시야 방해가 없어요"],
        isExpanded: false,
        showAllTags: .constant(false) /// 미리보기용, true/false 수동으로 바꿔서 봐야함ㅠㅋㅋ
    )
}
