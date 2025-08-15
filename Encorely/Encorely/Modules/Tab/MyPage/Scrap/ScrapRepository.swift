//
//  ScrapRepository.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

// Modules/Scrap/ScrapRepository.swift
import Foundation

protocol ScrapRepository {
    // Folders
    func fetchFolders() async -> [ScrapFolder]
    func createFolder(name: String) async -> ScrapFolder
    func renameFolder(id: UUID, newName: String) async
    func deleteFolder(id: UUID) async

    // Items
    func fetchItems(in folderId: UUID) async -> [ScrapItem]
}

final class StubScrapRepository: ScrapRepository {
    static let shared = StubScrapRepository()

    private init() {
        seed()
    }

    // MARK: - In-memory store
    private var folders: [ScrapFolder] = []

    private func seed() {
        if !folders.isEmpty { return }

        let sampleItems: [ScrapItem] = (0..<3).map { _ in
            ScrapItem(
                id: UUID(),
                userName: "Young1",
                seatText: "106구역 G열 13번",
                scrapCount: 10,
                rating: 4,
                imageNames: ["concertImage", "concertImage", "concertImage"],
                summary: "가수가 본 무대에 있었을 때는 잘 안보였는데 ... 꽤 좋은 자리인 것 같아요.",
                tags: ["돌출이 잘 보여요", "+3"]
            )
        }

        folders = [
            ScrapFolder(id: UUID(), name: "기본 폴더", coverImageName: "folder1", items: sampleItems),
            ScrapFolder(id: UUID(), name: "내가 만든 폴더 1", coverImageName: "folder2", items: sampleItems),
            ScrapFolder(id: UUID(), name: "내가 만든 폴더 2", coverImageName: "folder2", items: sampleItems)
        ]
    }

    // MARK: - Folders
    func fetchFolders() async -> [ScrapFolder] {
        folders
    }

    func createFolder(name: String) async -> ScrapFolder {
        let folder = ScrapFolder(id: UUID(), name: name, coverImageName: "folder2", items: [])
        folders.append(folder)
        return folder
    }

    func renameFolder(id: UUID, newName: String) async {
        guard let idx = folders.firstIndex(where: { $0.id == id }) else { return }
        folders[idx].name = newName
    }

    func deleteFolder(id: UUID) async {
        folders.removeAll { $0.id == id }
    }

    // MARK: - Items
    func fetchItems(in folderId: UUID) async -> [ScrapItem] {
        folders.first(where: { $0.id == folderId })?.items ?? []
    }

    // Helpers for name → id 매핑(기존 뷰 시그니처 유지용)
    func folderId(matching name: String) -> UUID? {
        folders.first(where: { $0.name == name })?.id
    }
}
