import Foundation

@MainActor
final class SettingViewModel: ObservableObject {
    @Published var serviceAlert: Bool {
        didSet { UserDefaults.standard.set(serviceAlert, forKey: "serviceAlert") }
    }
    @Published var eventAlert: Bool {
        didSet { UserDefaults.standard.set(eventAlert, forKey: "eventAlert") }
    }

    init() {
        serviceAlert = UserDefaults.standard.object(forKey: "serviceAlert") as? Bool ?? true
        eventAlert   = UserDefaults.standard.object(forKey: "eventAlert")   as? Bool ?? false
    }

    func logout() {
        TokenStore.shared.clear()
        ProfileStore.shared.clear()

        AuthStore.shared.isLoggedIn = false
        AuthStore.shared.hasSeenOnboarding = true

        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
        NotificationCenter.default.post(name: .profileDidChange, object: nil)
    }

    func withdraw() {
        TokenStore.shared.clear()
        ProfileStore.shared.clear()

        AuthStore.shared.isLoggedIn = false
        AuthStore.shared.hasSeenOnboarding = false

        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
        NotificationCenter.default.post(name: .profileDidChange, object: nil)
    }
}
