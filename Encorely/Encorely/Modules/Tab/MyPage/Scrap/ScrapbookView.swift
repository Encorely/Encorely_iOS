// Modules/Scrap/ScrapbookView.swift
import SwiftUI

struct ScrapbookView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = ScrapbookViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Button(action: { dismiss() }) {
                    Image("chevronLeft").resizable().frame(width: 30, height: 30)
                }
                Spacer()
                Text("스크랩북").font(.title3).bold()
                Spacer()
                Color.clear.frame(width: 30, height: 30)
            }
            .padding(.horizontal)
            .padding(.top, 16)

            Button(action: { Task { await vm.createFolder() } }) {
                HStack(spacing: 8) {
                    Image("newFolder").resizable().frame(width: 24, height: 24)
                    Text("새 폴더 만들기").font(.body).foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("grayColorG"))
                .cornerRadius(12)
            }
            .padding(.horizontal)

            HStack {
                Text("내가 만든 폴더").font(.headline)
                Text("\(vm.createdFolderCount)").font(.subheadline).foregroundColor(.gray)
            }
            .padding(.horizontal)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(vm.folders) { folder in
                        NavigationLink(destination: destinationView(for: folder.name)) {
                            FolderCardView(folder: Folder(imageName: folder.coverImageName, title: folder.name))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
        .task { await vm.load() }
    }

    // 기존 UI 로직 유지(이름으로 분기)
    @ViewBuilder
    func destinationView(for title: String) -> some View {
        switch title {
        case "기본 폴더", "기본폴더":
            BasicFolderView()
        case "내가 만든 폴더 1":
            MyFolder1View()
        default:
            Text("\(title) 상세보기 페이지는 준비 중입니다.")
        }
    }
}
