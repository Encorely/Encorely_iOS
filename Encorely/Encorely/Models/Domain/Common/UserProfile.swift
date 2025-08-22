import Foundation


struct UserProfile: Codable, Equatable {
    var nickname: String
    var introduction: String
    var link: String
    var imageData: Data?
}


extension Notification.Name {
    static let profileDidChange = Notification.Name("profileDidChange")
}


final class ProfileStore {
    static let shared = ProfileStore()
    private init() {}

    private let key = "user_profile_v1"

    func save(_ profile: UserProfile) {
        do {
            let data = try JSONEncoder().encode(profile)
            UserDefaults.standard.set(data, forKey: key)
            NotificationCenter.default.post(name: .profileDidChange, object: nil)
        } catch {
            print("❌ ProfileStore.save encode error:", error)
        }
    }

    func load() -> UserProfile? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(UserProfile.self, from: data)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
        NotificationCenter.default.post(name: .profileDidChange, object: nil)
    }
}
