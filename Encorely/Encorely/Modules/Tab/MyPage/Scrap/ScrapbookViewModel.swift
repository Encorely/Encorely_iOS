//
//  ScrapbookViewModel.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

// Modules/Scrap/ScrapbookViewModel.swift
import Foundation

@MainActor
final class ScrapbookViewModel: ObservableObject {
    @Published var folders: [ScrapFolder] = []
    private let repo: ScrapRepository

    init(repo: ScrapRepository = StubScrapRepository.shared) {
        self.repo = repo
        Task { await load() }
    }

    func load() async {
        folders = await repo.fetchFolders()
    }

    var createdFolderCount: Int {
        // "기본 폴더" 한 개 제외
        folders.filter { $0.name != "기본 폴더" }.count
    }

    func createFolder() async {
        _ = await repo.createFolder(name: "새 폴더")
        await load()
    }
}
