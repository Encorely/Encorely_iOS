//
//  FolderViewModel.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

// Modules/Scrap/FolderViewModel.swift
import Foundation

@MainActor
final class FolderViewModel: ObservableObject {
    @Published private(set) var folderId: UUID?
    @Published private(set) var items: [ScrapItem] = []
    @Published private(set) var filtered: [ScrapItem] = []

    // 필터 상태
    @Published var searchText: String = ""
    @Published var sort: String = "최신순"          // "최신순" | "인기순"
    @Published var category: String = "시야"        // UI 태그 예시

    private let repo: StubScrapRepository

    init(folderName: String, repo: StubScrapRepository = .shared) {
        self.repo = repo
        self.folderId = repo.folderId(matching: folderName)
        Task { await load() }
    }

    func load() async {
        guard let id = folderId else { return }
        items = await repo.fetchItems(in: id)
        applyFilters()
    }

    func applyFilters(search: String? = nil, sort: String? = nil, category: String? = nil) {
        if let s = search { self.searchText = s }
        if let so = sort { self.sort = so }
        if let c = category { self.category = c }

        var base = items

        if !searchText.isEmpty {
            base = base.filter {
                $0.userName.localizedCaseInsensitiveContains(searchText)
                || $0.seatText.localizedCaseInsensitiveContains(searchText)
                || $0.summary.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sort {
        case "인기순":
            base = base.sorted { $0.scrapCount > $1.scrapCount }
        default:
            // 최신순: id 생성시점을 가정해 그냥 기본 순서 유지
            break
        }

        // 카테고리는 샘플이라 태그와 단순 매칭(시야/편의시설/맛집/카페 등)
        if category != "전체" {
            base = base.filter { _ in true } // 실제 카테고리 키가 생기면 여기 분기
        }

        filtered = base
    }

    var itemCount: Int { filtered.count }

    // 편집/삭제
    func renameFolder(to newName: String) async {
        guard let id = folderId else { return }
        await repo.renameFolder(id: id, newName: newName)
    }

    func deleteFolder() async {
        guard let id = folderId else { return }
        await repo.deleteFolder(id: id)
    }
}
