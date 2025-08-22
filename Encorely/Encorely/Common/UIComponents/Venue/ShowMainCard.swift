//
//  ShowMainCard.swift
//  Encorely
//
//  Created by 이민서 on 8/14/25.
//

import SwiftUI
import Kingfisher

struct ShowMainCard: View {
    let ongoingShow: OngoingShow
    
    var body: some View {
        /*
        Button(action: {
            //TODO: - 연결 추가
        }) {
            VStack(alignment: .leading) {
                urlImage
                Spacer() .frame(height:10)
                showInfo
            }
            .frame(width: 135)
        }*/
        VStack(alignment: .leading) {
            urlImage
            Spacer() .frame(height:10)
            showInfo
        }
        .frame(width: 135)
    }
    
    //MARK: - 공연 이미지
    @ViewBuilder
    private var urlImage : some View {
        if let url = URL(string: ongoingShow.imageUrl) {
            KFImage(url)
                .placeholder({
                    ProgressView()
                        .controlSize(.mini)
                }).retry(maxCount: 2, interval: .seconds(2))
                .onFailure { error in
                    print("이미지 로드 실패: \(error)")
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 135, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .clipped()
        }
    }
    
    //MARK: - 공연 정보
    private var showInfo : some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(ongoingShow.showName)
                .font(.mainTextMedium16)
                .foregroundStyle(.grayColorA)
                .multilineTextAlignment(.leading) //텍스트 무조건 왼쪽 정렬되도록!
                .lineLimit(2) ///두 줄 고정
                .truncationMode(.tail) ///길면 뒷부분 잘리게
        
            Text(ongoingShow.hallName)
                .font(.mainTextMedium15)
                .foregroundStyle(.grayColorC)
                .multilineTextAlignment(.leading)
                
            Text("\(ongoingShow.startDate)~\(ongoingShow.endDate)")
                .font(.mainTextMedium13)
                .foregroundStyle(.grayColorF)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    ShowMainCard(
        ongoingShow: OngoingShow(
            id: 1,
            imageUrl:"https://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2025/05/15/a6d83975-7814-435a-8432-1a1bbbb6c16e.jpg",
            showName: "KISS OF LIFE 1st WORLD TOUR",
            hallId: 1,
            hallName: "장충체육관",
            startDate: "2025.07.19",
            endDate: "2025.07.20"
        )
    )
}
