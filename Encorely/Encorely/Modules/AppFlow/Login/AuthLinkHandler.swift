//
//  AuthLinkHandler.swift
//  Encorely
//
//  Created by Kehyuk on 8/21/25.
//

import Foundation

final class AuthLinkHandler: ObservableObject {
    static let shared = AuthLinkHandler()

    enum Status: Equatable {
        case idle
        case success(AuthTokens)     // 토큰이든 code든 임시 저장
        case failure(String)
    }

    @Published var status: Status = .idle

    /// encorely://oauth/kakao?... 형태를 파싱
    func handle(_ url: URL) {
        guard url.scheme?.lowercased() == "encorely" else { return }

        let comps = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let q = comps?.queryItems ?? []

        let access  = q.first { ["access", "accesstoken"].contains($0.name.lowercased()) }?.value
        let refresh = q.first { ["refresh", "refreshtoken"].contains($0.name.lowercased()) }?.value
        if let access {
            status = .success(.init(access: access, refresh: refresh))
            return
        }
        if let code = q.first(where: { $0.name.lowercased() == "code" })?.value {
            status = .success(.init(access: code, refresh: nil))
            return
        }
        status = .failure("잘못된 콜백 URL")
    }

    func reset() { status = .idle }
}
