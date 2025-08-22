//
//  UserProfileStore.swift
//  Encorely
//
//  Created by Kehyuk on 8/22/25.
//

import SwiftUI

/// 간단 영구 저장(초기 프로필 정보)
final class UserProfileStore: ObservableObject {
    static let shared = UserProfileStore()

    // UserDefaults(AppStorage)로 보존
    @AppStorage("profile.nickname") private var nicknameStore: String = ""
    @AppStorage("profile.introduction") private var introStore: String = ""
    @AppStorage("profile.link") private var linkStore: String = ""
    @AppStorage("profile.image") private var imageDataStore: Data = Data()

    @Published var nickname: String = ""
    @Published var introduction: String = ""
    @Published var personalLink: String = ""
    @Published var image: UIImage?

    private init() {
        nickname = nicknameStore
        introduction = introStore
        personalLink = linkStore
        if !imageDataStore.isEmpty { image = UIImage(data: imageDataStore) }
    }

    func update(nickname: String, introduction: String, link: String, image: UIImage?) {
        self.nickname = nickname
        self.introduction = introduction
        self.personalLink = link
        self.image = image

        // 영구 저장
        nicknameStore = nickname
        introStore = introduction
        linkStore = link
        imageDataStore = image?.jpegData(compressionQuality: 0.85) ?? Data()
    }
}
