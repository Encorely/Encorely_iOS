// Modules/Scrap/BasicFolderView.swift
import SwiftUI

struct BasicFolderView: View {
    @Environment(\.dismiss) var dismiss

    @State private var showPopupMenu = false
    @State private var showDeleteAlert = false
    @State private var showEditSheet = false
    @State private var showFilterSheet = false
    @State private var folderName: String = "기본 폴더"

    // 필터 상태 변수 (UI 그대로)
    @State private var searchText: String = ""
    @State private var selectedSort: String = "최신순"
    @State private var selectedCategory: String = "시야"
    @FocusState private var isTextFieldFocused: Bool

    private let sorts = ["최신순", "인기순"]
    private let categories = ["시야", "편의시설", "맛집/카페"]

    @StateObject private var vm = FolderViewModel(folderName: "기본 폴더")

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 16) {
                // 상단 네비게이션 바
                HStack {
                    Button(action: { dismiss() }) {
                        Image("chevronLeft").resizable().frame(width: 30, height: 30)
                    }
                    Spacer()
                    Text("스크랩북").font(.headline).fontWeight(.semibold)
                    Spacer()
                    Button(action: { withAnimation { showPopupMenu.toggle() } }) {
                        Image("moreBtn").resizable().frame(width: 30, height: 30)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)

                // 폴더 제목 & 카운트 & 필터 버튼
                HStack {
                    Text(folderName).font(.title3).fontWeight(.semibold)
                    Text("\(vm.itemCount)").foregroundColor(.gray)
                    Spacer()
                    Button(action: { showFilterSheet = true }) {
                        HStack(spacing: 4) {
                            Text("필터").font(.subheadline).foregroundColor(.black)
                            Image("filterBtn").resizable().frame(width: 18, height: 18)
                        }
                    }
                }
                .padding(.horizontal)

                // 카드 리스트 (UI 유지 / 더미 3개 → 필터된 개수만큼)
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(0..<vm.itemCount, id: \.self) { _ in
                            BasicFolderScrapCardView()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)

            // 더보기 팝업
            if showPopupMenu {
                VStack(spacing: 0) {
                    Button(action: { showEditSheet = true; showPopupMenu = false }) {
                        Text("폴더 수정").foregroundColor(.black)
                            .padding().frame(width: 120, alignment: .leading)
                    }
                    Button(action: { showDeleteAlert = true; showPopupMenu = false }) {
                        Text("폴더 삭제").foregroundColor(.black)
                            .padding().frame(width: 120, alignment: .leading)
                    }
                }
                .background(Color.white).cornerRadius(10).shadow(radius: 5)
                .padding(.trailing, 16).offset(y: 45)
            }

            // 삭제 확인
            if showDeleteAlert {
                Color.black.opacity(0.4).ignoresSafeArea().onTapGesture { showDeleteAlert = false }
                VStack(spacing: 16) {
                    Text("\(folderName)을 삭제하시겠어요?").font(.headline).fontWeight(.semibold).multilineTextAlignment(.center)
                    Text("폴더를 삭제하면 복구는 불가능합니다.").font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center)
                    HStack(spacing: 12) {
                        Button(action: { showDeleteAlert = false }) {
                            Text("취소").foregroundColor(.black)
                                .frame(maxWidth: .infinity).padding()
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                                .cornerRadius(10)
                        }
                        Button(action: {
                            Task {
                                await vm.deleteFolder()
                                showDeleteAlert = false
                                dismiss()
                            }
                        }) {
                            Text("삭제").foregroundColor(.white)
                                .frame(maxWidth: .infinity).padding()
                                .background(Color(.mainColorA)).cornerRadius(10)
                        }
                    }
                }
                .padding().background(Color.white).cornerRadius(16)
                .padding(.horizontal, 40).frame(maxHeight: .infinity, alignment: .center)
            }
        }
        // 필터 시트 (UI 동일, 적용 시 VM 필터 호출)
        .sheet(isPresented: $showFilterSheet) {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("공연장").font(.subheadline).fontWeight(.medium)
                    HStack {
                        Image("searchBtn").resizable().frame(width: 18, height: 18).padding(.leading, 12)
                        TextField("내가 찾고 싶은 공연장을 입력하세요", text: $searchText)
                            .padding(.vertical, 12)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("정렬").font(.subheadline).fontWeight(.medium)
                    HStack(spacing: 10) {
                        ForEach(sorts, id: \.self) { sort in
                            Text(sort)
                                .font(.caption)
                                .padding(.horizontal, 14).padding(.vertical, 8)
                                .foregroundColor(selectedSort == sort ? .white : .black)
                                .background(
                                    selectedSort == sort
                                    ? AnyView(Capsule().fill(Color("mainColorB")))
                                    : AnyView(Capsule().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                                )
                                .onTapGesture { selectedSort = sort }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("카테고리").font(.subheadline).fontWeight(.medium)
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .font(.caption)
                                .padding(.horizontal, 14).padding(.vertical, 8)
                                .foregroundColor(selectedCategory == category ? .white : .black)
                                .background(
                                    selectedCategory == category
                                    ? AnyView(Capsule().fill(Color("mainColorB")))
                                    : AnyView(Capsule().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                                )
                                .onTapGesture { selectedCategory = category }
                        }
                    }
                }

                Spacer()

                Button(action: {
                    vm.applyFilters(search: searchText, sort: selectedSort, category: selectedCategory)
                    showFilterSheet = false
                }) {
                    Text("적용").fontWeight(.semibold).foregroundColor(.white)
                        .frame(maxWidth: .infinity).padding()
                        .background(Color("mainColorB")).cornerRadius(12)
                }
            }
            .padding(.horizontal, 20).padding(.top, 40).padding(.bottom, 20)
            .background(Color.white)
            .presentationDetents([.height(450)]).presentationDragIndicator(.hidden)
        }

        // 폴더 수정 시트 (UI 유지, 저장 시 VM 호출)
        .sheet(isPresented: $showEditSheet) {
            VStack(spacing: 0) {
                HStack {
                    Button(action: { showEditSheet = false }) {
                        Image("chevronLeft").resizable().frame(width: 30, height: 30)
                    }
                    Spacer()
                    Text("폴더 수정").font(.headline).fontWeight(.semibold)
                    Spacer()
                    Color.clear.frame(width: 30, height: 30)
                }
                .padding(.horizontal).padding(.top, 20).padding(.bottom, 24)

                VStack(alignment: .leading, spacing: 12) {
                    Text("폴더 이름").font(.subheadline).fontWeight(.medium)
                    TextField("폴더명을 입력하세요", text: $folderName)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                }
                .padding(.horizontal, 20)

                Spacer()

                Button(action: {
                    Task { await vm.renameFolder(to: folderName) }
                    showEditSheet = false
                }) {
                    Text("수정").fontWeight(.semibold).foregroundColor(.white)
                        .frame(maxWidth: .infinity).padding()
                        .background(Color("mainColorB")).cornerRadius(12)
                }
                .padding(.horizontal, 20).padding(.bottom, 24)
            }
            .background(Color.white)
            .presentationDetents([.height(300)]).presentationDragIndicator(.hidden)
        }
        .task { await vm.load() }
    }
}
