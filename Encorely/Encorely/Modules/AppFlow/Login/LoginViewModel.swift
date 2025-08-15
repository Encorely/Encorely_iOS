import Foundation

@MainActor
final class LoginViewModel: ObservableObject {

    enum State: Equatable {
        case idle
        case loading
        case success(AuthTokens)
        case failure(String)
    }

    @Published var state: State = .idle
    private let repo: AuthRepository

    /// DEBUG 빌드에선 Stub, RELEASE 빌드에선 Default 레포 자동 사용
    init(repo: AuthRepository? = nil) {
        #if DEBUG
        self.repo = repo ?? StubAuthRepository()
        #else
        self.repo = repo ?? DefaultAuthRepository()
        #endif
    }

    func loginWithKakao() async {
        await login { try await repo.loginWithKakao() }
    }

    func loginWithApple() async {
        await login { try await repo.loginWithApple() }
    }

    private func login(_ action: () async throws -> AuthTokens) async {
        state = .loading
        do {
            let tokens = try await action()
            // TokenStore.shared.save(access: tokens.access, refresh: tokens.refresh) // 필요 시 사용
            state = .success(tokens)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
