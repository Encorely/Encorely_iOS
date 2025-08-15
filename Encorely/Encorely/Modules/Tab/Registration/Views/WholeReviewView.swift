//
//  WholeReviewView.swift
//  Encorely
//
//  Created by 이예지 on 7/31/25.
//

import SwiftUI

struct WholeReviewView: View {
    
    @ObservedObject var viewModel = RegistViewModel()
    @Environment(\.dismiss) var dismiss
    
    let goodkeywordList = KeywordType.goodSeatTag
    let badkeywordList = KeywordType.badSeatTag
    let restaurantList = KeywordType.RestaurantTag
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 41) {
                topContents
                middleSeatContents
                middleRestaurantContents
//                middleFacilityContents
//                    .padding(.bottom, -26)
//                bottomContents
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 16)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: { dismiss() }) {
                    Image(.chevronLeft)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.grayColorA)
                }
            })
            
            ToolbarItem(placement: .principal, content: {
                Text("KPOP_lover")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(Color.grayColorA)
            })
        })
    }
    
    // MARK: topContents
    /// 공연 기본 정보
    /// - 공연일, 공연회차, 공연명, 공연사진, 공연 한줄평, 공연 자세한 후기
    private var topContents: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 25) {
                HStack(spacing: 15) {
                    Text("2023. 11. 19")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 9)
                        .performanceInfoModifier()
                    
                    Text("3회차")
                        .padding(.horizontal, 26)
                        .padding(.vertical, 9)
                        .performanceInfoModifier()
                    
                    Spacer()
                }
                .padding(.horizontal, 1)
                
                Text("NCT 127 3RD TOUR THE UNITY")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.grayColorA)
            }
            
            Image(.pfimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 15) {
                Text("눈과 귀가 즐거운 퍼포먼스가 많은 콘서트")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.grayColorA)
                
                Text("내가 좋아하는 곡을 많이 해주진 않아서 아쉬웠지만 지금까지 하지 않았던 퍼포먼스나 무대 장치가 다양하고 새로운 시도를 많이 해서 좋았다. 그리고 오빠들이 잘생김ㅎ")
                    .font(.mainTextRegular16)
                    .foregroundStyle(.grayColorC)
                    
            }
        }
    }
    
    // MARK: middleSeatContents
    /// 시야/좌석
    /// - 시야사진, 공연장 이름, 좌석, 별점, 좌석 자세한 후기, 키워드평가
    private var middleSeatContents: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("시야/좌석")
                .purpleRoundedRectangleModifier()
            
            Image(.sgimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack(spacing: 5) {
                Image("location")
                    .resizable()
                    .frame(width: 12, height: 15)
                
                Text("KSPO DOME")
                    .font(.mainTextMedium16)
            }
            .locationModifier()
            .padding(.horizontal, 1)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("3구역 20열 11번")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.grayColorA)
                HStack(spacing: 5) {
                    Image(.fillStar)
                    Image(.fillStar)
                    Image(.fillStar)
                    Image(.fillStar)
                    Image(.fillStar)
                }
            }
            
            Text("돌출 나오면 가수가 코앞에서 보임. 진짜 시야 굿굿")
                .font(.mainTextRegular16)
                .foregroundStyle(.grayColorC)
            
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    KeywordStyle(keywordType: goodkeywordList[0])
                    KeywordStyle(keywordType: goodkeywordList[6])
                }
                KeywordStyle(keywordType: goodkeywordList[7])
            }
        }
    }
    
    // MARK: middleRestaurantContents
    /// 맛집
    /// - 사진, 가게 이름, 지도에서 위치보기, 맛집 자세한 후기, 키워드 평가
    private var middleRestaurantContents: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("밥집")
                .purpleRoundedRectangleModifier()
            
            Image(.rtimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 13) {
                HStack(spacing: 5) {
                    Image("location")
                        .resizable()
                        .frame(width: 12, height: 15)
                    
                    Text("수작나베 올림픽 공원직영점")
                        .font(.mainTextMedium16)
                }
                .locationModifier()
                .padding(.horizontal, 1)
                
                Button(action: {
                    // TODO: 웹으로 지도 띄우기
                }) {
                    facilityMapButton()
                }
                
                Text("추운날이여서 따뜻한걸 먹고 싶어서 찾다가 스키아키집을 발견해서 왔음. 좀 걸어와야 했지만 사람도 없고 넘 맛있어서 좋았음.")
                    .font(.mainTextRegular16)
                    .foregroundStyle(.grayColorC)
            }
            
            HStack(spacing: 5) {
                KeywordStyle(keywordType: restaurantList[4])
            }
        }
    }
    
    // MARK: middleFacilityContents
    /// 편의시설
    /// - 사진, 지도에서 위치보기, 편의시설 자세한 후기
//    private var middleFacilityContents: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            VStack(alignment: .leading, spacing: 15) {
//                Text("편의시설 종류 띄우기")
//                    .purpleRoundedRectangleModifier()
//                
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(height: 341)
//            }
//            
//            Button(action: {
//                // TODO: 웹으로 지도 띄우기
//            }) {
//                facilityMapButton()
//            }
//            
//            Text("편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기")
//                .font(.mainTextRegular16)
//                .foregroundStyle(.grayColorC)
//        }
//    }
//    
//    // MARK: bottomContents
//    /// 댓글창
//    /// - 댓글과 대댓글이 보입니다
//    private var bottomContents: some View {
//        VStack(alignment: .leading, spacing: 18) {
//            VStack(alignment: .leading, spacing: 8) {
//                Divider()
//                    .background(Color.gray)
//                    .frame(maxWidth: .infinity)
//                
//                HStack(spacing: 10) {
//                    HStack(spacing: 2) {
//                        Image("heart")
//                            .resizable()
//                            .frame(width: 24, height: 24)
//                            .foregroundStyle(.mainColorB)
//                        
//                        Text("수")
//                            .font(.mainTextMedium16)
//                            .foregroundStyle(.grayColorA)
//                    }
//                    
//                    HStack(spacing: 5) {
//                        Image("comment")
//                            .resizable()
//                            .frame(width: 24, height: 24)
//                            .foregroundStyle(.mainColorB)
//                        
//                        Text("수")
//                            .font(.mainTextMedium16)
//                            .foregroundStyle(.grayColorA)
//                    }
//                    
//                    HStack(spacing: 5) {
//                        Image("scrap")
//                            .resizable()
//                            .frame(width: 24, height: 24)
//                            .foregroundStyle(.mainColorB)
//                        
//                        Text("수")
//                            .font(.mainTextMedium16)
//                            .foregroundStyle(.grayColorA)
//                    }
//                }
//                
//                Divider()
//                    .background(Color.gray)
//                    .frame(maxWidth: .infinity)
//            }
//            
//            VStack(alignment: .leading, spacing: 19) {
//                Text("댓글")
//            }
//        }
//    }
    
}

#Preview {
    WholeReviewView()
}
