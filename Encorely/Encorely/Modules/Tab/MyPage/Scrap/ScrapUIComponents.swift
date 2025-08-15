//
//  ScrapUIComponents.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

// Modules/Scrap/ScrapUIComponents.swift
import SwiftUI

// MARK: - View 전용 Folder (ScrapFolder와 이름 겹치지 않게 별개 유지)
struct Folder: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
}

// MARK: - 그리드 카드
struct FolderCardView: View {
    let folder: Folder

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(folder.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(10)

            Text(folder.title)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal, 4)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - 기본 폴더 카드(리스트용) – 기존 UI 그대로
struct BasicFolderScrapCardView: View {
    let starCount = 4

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Image("sampleProfile")
                    .resizable()
                    .frame(width: 39, height: 39)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text("Young1")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text("106구역 G열 13번 | 스크랩 수 10")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Image("scrapBookMark")
                    .resizable()
                    .frame(width: 18, height: 25)
            }

            HStack(spacing: 2) {
                ForEach(0..<starCount, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("subColorA"))
                        .font(.caption)
                }
            }

            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { _ in
                    Image("concertImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width - 64) / 3, height: 80)
                        .clipped()
                        .cornerRadius(6)
                }
            }

            Text("가수가 본 무대에 있었을 때는 잘 안보였는데 돌출로 나오니까 너무 잘보였어요. 시야 방해는 없었어요. 사진보다 실제로 더 가까이 보여서 꽤 좋은 자리인 것 같아요.")
                .font(.caption)
                .lineLimit(3)

            HStack(spacing: 6) {
                Text("돌출이 잘 보여요")
                    .font(.caption2)
                    .foregroundColor(Color("subColorB"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("subColorH"))
                    .clipShape(Capsule())

                Text("+3")
                    .font(.caption2)
                    .foregroundColor(Color("subColorB"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("subColorH"))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("mainColorA"), lineWidth: 1)
                .background(Color("grayScaleF").cornerRadius(12))
        )
    }
}

// MARK: - 내가 만든 폴더1 카드(리스트용) – 기존 UI 그대로
struct MyFolder1ScrapCardView: View {
    let starCount = 4

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Image("sampleProfile")
                    .resizable()
                    .frame(width: 39, height: 39)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text("Young1")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text("106구역 G열 13번 | 스크랩 수 10")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Image("scrapBookMark")
                    .resizable()
                    .frame(width: 18, height: 25)
            }

            HStack(spacing: 2) {
                ForEach(0..<starCount, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("subColorA"))
                        .font(.caption)
                }
            }

            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { _ in
                    Image("concertImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width - 64) / 3, height: 80)
                        .clipped()
                        .cornerRadius(6)
                }
            }

            Text("가수가 본 무대에 있었을 때는 잘 안보였는데 돌출로 나오니까 너무 잘보였어요. 시야 방해는 없었어요. 사진보다 실제로 더 가까이 보여서 꽤 좋은 자리인 것 같아요.")
                .font(.caption)
                .lineLimit(3)

            HStack(spacing: 6) {
                Text("돌출이 잘 보여요")
                    .font(.caption2)
                    .foregroundColor(Color("subColorB"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("subColorH"))
                    .clipShape(Capsule())

                Text("+3")
                    .font(.caption2)
                    .foregroundColor(Color("subColorB"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("subColorH"))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("mainColorA"), lineWidth: 1)
                .background(Color("grayScaleF").cornerRadius(12))
        )
    }
}
