//
//  KeywordListView.swift
//  Encorely
//
//  Created by 이예지 on 7/25/25.
//

import SwiftUI

struct KeywordListView: View {
    
    @ObservedObject var viewModel: RegistViewModel
    let keywordList: [KeywordType]
    
    private var dividedList: [[KeywordType]] {
        var rows: [[KeywordType]] = Array(repeating: [], count: 3)
        for (index, keyword) in keywordList.enumerated() {
            rows[index % 3].append(keyword)
        }
        return rows
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 15) {
                ForEach(dividedList, id: \.self) { column in
                    VStack {
                        ForEach(column) { keyword in
                            GoodKeywordRating(
                                viewModel: viewModel,
                                keywordType: keyword
                            )
                        }
                    }
                }
            }
        }
    }
}
