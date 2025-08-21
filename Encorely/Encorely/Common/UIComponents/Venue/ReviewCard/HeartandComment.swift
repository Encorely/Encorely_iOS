//
//  HeartandComment.swift
//  Encorely
//
//  Created by 이민서 on 8/21/25.
//

import SwiftUI

struct HeartandComment: View {
   
    let commentCount: Int
    
    @State private var isHearted: Bool = false
    @State private var likeCount: Int

    init(likeCount: Int, commentCount: Int) {
        self.commentCount = commentCount
        _likeCount = State(initialValue: likeCount)
    }
    
    var body: some View {
        HStack(spacing:10) {
            heartView
            commentView
        }
    }
    
    private var heartView : some View {
        HStack(spacing:2) {
            Button(action: {
                isHearted.toggle()
            }) {
                Image(isHearted ? .filledHeart : .heart)
                    .frame(width: 25, height: 25)
            }
            Text(isHearted ? "\(likeCount+1)" : "\(likeCount)")
        }
    }
    
    private var commentView : some View {
        HStack(spacing:5) {
            Button(action: {}
            ){
                Image(.comment)
                    .frame(width: 25, height: 25)
            }
            Text("\(commentCount)")
        }
    }
}

extension HeartandComment {
    init(_ model: FnbReview) {
        self.init(likeCount: model.likeCount, commentCount: model.commentCount)
    }
    init(_ model: FacilityReview) {
        self.init(likeCount: model.likeCount, commentCount: model.commentCount)
    }
    
    init(_ model: SeatReview) {
        self.init(likeCount: model.likeCount, commentCount: model.commentCount)
    }
}

//프리뷰 포깅
