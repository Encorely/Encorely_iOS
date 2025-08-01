//
//  WholeReviewView.swift
//  Encorely
//
//  Created by 이예지 on 7/31/25.
//

import SwiftUI

struct WholeReviewView: View {
    
    @StateObject var mainViewModel = MainReviewRegistViewModel()
    @StateObject var subViewModel = SubRegistViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 41) {
                topContents
                middleSeatContents
                middleRestaurantContents
                middleFacilityContents
                bottomContents
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 16)
    }
    
    private var topContents: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 25) {
                HStack(spacing: 15) {
                    Text("공연일")
                    Text("공연회차")
                    Spacer()
                }
                Text("공연명")
            }
            
            Text("공연사진")
            
            VStack(alignment: .leading, spacing: 15) {
                Text("공연 한줄평")
                Text("공연 자세한 후기")
            }
        }
    }
    
    private var middleSeatContents: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("시야/좌석")
            Text("시야사진")
            Text("공연장 이름")
            
            VStack(alignment: .leading, spacing: 5) {
                Text("좌석")
                HStack(spacing: 5) {
                    Text("별점")
                }
            }
            
            Text("좌석 자세한 후기")
            
            HStack(spacing: 5) {
                Text("키워드평가")
            }
        }
    }
    
    private var middleRestaurantContents: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("밥집/카페/술집 중 하나 띄우기")
            Text("사진")
            
            VStack(alignment: .leading, spacing: 13) {
                Text("가게 이름")
                Text("지도에서 위치보기")
                Text("맛집 자세한 후기")
            }
            
            HStack(spacing: 5) {
                Text("키워드평가")
            }
        }
    }
    
    private var middleFacilityContents: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 15) {
                Text("편의시설 종류 띄우기")
                Text("사진")
            }
            
            Text("지도에서 위치보기")
            Text("편의시설 자세한 후기")
        }
    }
    
    private var bottomContents: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 8) {
                Divider()
                    .background(Color.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, -16)
                
                HStack(spacing: 10) {
                    HStack(spacing: 2) {
                        Text("하트")
                        Text("수")
                    }
                    
                    HStack(spacing: 5) {
                        Text("댓글")
                        Text("수")
                    }
                    
                    HStack(spacing: 5) {
                        Text("스크랩")
                        Text("수")
                    }
                }
                
                Divider()
                    .background(Color.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, -16)
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
