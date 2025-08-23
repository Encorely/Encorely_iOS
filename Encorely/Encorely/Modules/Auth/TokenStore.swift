import Foundation

final class TokenStore {
    static let shared = TokenStore()
    private init() {}

    struct AuthTokens: Codable, Equatable {
        let access: String
        let refresh: String?
        let expiresAt: Date?
    }

    private let key = "auth.tokens.v1"

    func save(access: String, refresh: String?, expiresAt: Date?) {
        let tokens = AuthTokens(access: access, refresh: refresh, expiresAt: expiresAt)
        do {
            let data = try JSONEncoder().encode(tokens)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("TokenStore.save error:", error)
        }
    }

    func load() -> AuthTokens? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(AuthTokens.self, from: data)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
