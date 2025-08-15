//
//  WholeReviewView.swift
//  Encorely
//
//  Created by 이예지 on 7/31/25.
//

import SwiftUI

struct WholeReviewView: View {
    
    @ObservedObject var viewModel = RegistViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 41) {
                topContents
                middleSeatContents
                middleRestaurantContents
                middleFacilityContents
                    .padding(.bottom, -26)
                bottomContents
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: topContents
    /// 공연 기본 정보
    /// - 공연일, 공연회차, 공연명, 공연사진, 공연 한줄평, 공연 자세한 후기
    private var topContents: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 25) {
                HStack(spacing: 15) {
                    Text("공연일")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 9)
                        .performanceInfoModifier()
                    
                    Text("공연 회차")
                        .padding(.horizontal, 26)
                        .padding(.vertical, 9)
                        .performanceInfoModifier()
                    
                    Spacer()
                }
                .padding(.horizontal, 1)
                
                Text("공연명")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.grayColorA)
            }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 341)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("공연 한줄평")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.grayColorA)
                
                Text("공연 자세한 후기 공연 자세한 후기 공연 자세한 후기 공연 자세한 후기 공연 자세한 후기 공연 자세한 후기 공연 자세한 후기 공연 자세한 후기 공연 자세한 후기")
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
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 341)
            
            HStack(spacing: 5) {
                Image("location")
                    .resizable()
                    .frame(width: 12, height: 15)
                
                Text("공연장 이름")
                    .font(.mainTextMedium16)
            }
            .locationModifier()
            .padding(.horizontal, 1)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("  구역  열  번")
                    .font(.mainTextSemiBold20)
                    .foregroundStyle(.grayColorA)
                HStack(spacing: 5) {
                    Text("별점")
                }
            }
            
            Text("좌석 자세한 후기 좌석 자세한 후기 좌석 자세한 후기 좌석 자세한 후기 좌석 자세한 후기 좌석 자세한 후기 좌석 자세한 후기 좌석 자세한 후기 좌석 자세한 후기 좌석 자세한 후기")
                .font(.mainTextRegular16)
                .foregroundStyle(.grayColorC)
            
            HStack(spacing: 5) {
                Text("키워드평가")
            }
        }
    }
    
    // MARK: middleRestaurantContents
    /// 맛집
    /// - 사진, 가게 이름, 지도에서 위치보기, 맛집 자세한 후기, 키워드 평가
    private var middleRestaurantContents: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("밥집/카페/술집 중 하나 띄우기")
                .purpleRoundedRectangleModifier()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 341)
            
            VStack(alignment: .leading, spacing: 13) {
                HStack(spacing: 5) {
                    Image("location")
                        .resizable()
                        .frame(width: 12, height: 15)
                    
                    Text("가게 이름")
                        .font(.mainTextMedium16)
                }
                .locationModifier()
                .padding(.horizontal, 1)
                
                Button(action: {
                    // TODO: 웹으로 지도 띄우기
                }) {
                    facilityMapButton()
                }
                
                Text("맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기 맛집 자세한 후기")
                    .font(.mainTextRegular16)
                    .foregroundStyle(.grayColorC)
            }
            
            HStack(spacing: 5) {
                Text("키워드평가")
            }
        }
    }
    
    // MARK: middleFacilityContents
    /// 편의시설
    /// - 사진, 지도에서 위치보기, 편의시설 자세한 후기
    private var middleFacilityContents: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 15) {
                Text("편의시설 종류 띄우기")
                    .purpleRoundedRectangleModifier()
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 341)
            }
            
            Button(action: {
                // TODO: 웹으로 지도 띄우기
            }) {
                facilityMapButton()
            }
            
            Text("편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기 편의시설 자세한 후기")
                .font(.mainTextRegular16)
                .foregroundStyle(.grayColorC)
        }
    }
    
    // MARK: bottomContents
    /// 댓글창
    /// - 댓글과 대댓글이 보입니다
    private var bottomContents: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 8) {
                Divider()
                    .background(Color.gray)
                    .frame(maxWidth: .infinity)
                
                HStack(spacing: 10) {
                    HStack(spacing: 2) {
                        Image("heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.mainColorB)
                        
                        Text("수")
                            .font(.mainTextMedium16)
                            .foregroundStyle(.grayColorA)
                    }
                    
                    HStack(spacing: 5) {
                        Image("comment")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.mainColorB)
                        
                        Text("수")
                            .font(.mainTextMedium16)
                            .foregroundStyle(.grayColorA)
                    }
                    
                    HStack(spacing: 5) {
                        Image("scrap")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.mainColorB)
                        
                        Text("수")
                            .font(.mainTextMedium16)
                            .foregroundStyle(.grayColorA)
                    }
                }
                
                Divider()
                    .background(Color.gray)
                    .frame(maxWidth: .infinity)
            }
            
            VStack(alignment: .leading, spacing: 19) {
                Text("댓글")
            }
        }
    }
    
}

#Preview {
    WholeReviewView()
}
