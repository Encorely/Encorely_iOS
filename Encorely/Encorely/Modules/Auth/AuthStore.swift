//
//  AuthStore.swift
//  Encorely
//
//  Created by Kehyuk on 8/23/25.
//

import SwiftUI

final class AuthStore: ObservableObject {
    static let shared = AuthStore()

    @Published var isLoggedIn: Bool {
        didSet {
            if !isLoggedIn { TokenStore.shared.clear() }
            postChange()
        }
    }

    @Published var hasSeenOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(hasSeenOnboarding, forKey: Self.onboardingKey)
            postChange()
        }
    }

    private init() {
        isLoggedIn = (TokenStore.shared.load() != nil)
        hasSeenOnboarding = UserDefaults.standard.bool(forKey: Self.onboardingKey)
    }

    private func postChange() {
        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
    }

    private static let onboardingKey = "auth.hasSeenOnboarding.v1"
}

extension Notification.Name {
    static let authStateDidChange = Notification.Name("authStateDidChange")
}
