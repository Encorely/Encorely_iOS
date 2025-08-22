import Foundation
import AuthenticationServices
import UIKit

protocol AuthRepository {
    func loginWithKakao() async throws -> AuthTokens
    func loginWithApple() async throws -> AuthTokens
}

// 실서버 구현
final class DefaultAuthRepository: NSObject, AuthRepository, ASWebAuthenticationPresentationContextProviding {

    // 서버가 준 엔드포인트 (http → ATS 예외 필요)
    private let authURL = URL(string: "http://13.209.39.26:8080/oauth2/authorization/kakao")!

    // Info.plist 에 등록한 스킴
    private let callbackScheme = "encorely"

    // 세션을 강하게 유지 (표시 중 retain)
    private var currentSession: ASWebAuthenticationSession?

    // MARK: - Kakao
    func loginWithKakao() async throws -> AuthTokens {
        #if DEBUG
        print("🔐 [Kakao] start web-auth:", authURL.absoluteString)
        #endif
        let callbackURL = try await startWebAuth(url: authURL, callbackScheme: callbackScheme)

        #if DEBUG
        print("🔙 [Kakao] callback url:", callbackURL.absoluteString)
        #endif

        if let comps = URLComponents(url: callbackURL, resolvingAgainstBaseURL: false) {
            let q = comps.queryItems ?? []
            let access = q.first { ["access","accesstoken"].contains($0.name.lowercased()) }?.value
            let refresh = q.first { ["refresh","refreshtoken"].contains($0.name.lowercased()) }?.value
            if let access {
                return AuthTokens(access: access, refresh: refresh)
            }
            if let code = q.first(where: { $0.name.lowercased() == "code" })?.value {
                #if DEBUG
                print("ℹ️ [Kakao] got code:", code)
                #endif
                return try await exchangeCodeForToken(code: code)
            }
        }
        throw NSError(domain: "Login", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: "카카오 로그인 콜백 파싱 실패"])
    }

    func loginWithApple() async throws -> AuthTokens {
        throw NSError(domain: "Login", code: -2,
                      userInfo: [NSLocalizedDescriptionKey: "Apple 로그인은 추후 구현"])
    }

    // MARK: - Web Auth
    private func startWebAuth(url: URL, callbackScheme: String) async throws -> URL {
        try await withCheckedThrowingContinuation { cont in
            let session = ASWebAuthenticationSession(
                url: url,
                callbackURLScheme: callbackScheme
            ) { [weak self] callbackURL, error in
                // 세션 해제
                self?.currentSession = nil
                if let url = callbackURL {
                    cont.resume(returning: url)
                } else {
                    cont.resume(throwing: error ?? NSError(
                        domain: "Login", code: -3,
                        userInfo: [NSLocalizedDescriptionKey: "사용자 취소 또는 표시 실패"]
                    ))
                }
            }
            session.presentationContextProvider = self
            session.prefersEphemeralWebBrowserSession = true

            // 강한 참조 보관
            self.currentSession = session

            let started = session.start()
            if !started {
                self.currentSession = nil
                cont.resume(throwing: NSError(
                    domain: "Login", code: -4,
                    userInfo: [NSLocalizedDescriptionKey: "웹 인증 시작 실패"]
                ))
            }
        }
    }

    // 웹 인증 표시용 앵커
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.firstKeyWindow ?? UIWindow()
    }

    // MARK: - code → token 교환(서버가 code만 주는 경우)
    private func exchangeCodeForToken(code: String) async throws -> AuthTokens {
        // TODO: Swagger 스펙에 맞춰 채우기
        throw NSError(domain: "Login", code: -5,
                      userInfo: [NSLocalizedDescriptionKey: "토큰 교환 API 스펙 필요"])
    }
}

// 편의: keyWindow
private extension UIApplication {
    var firstKeyWindow: UIWindow? {
        connectedScenes.compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}

#if DEBUG
final class StubAuthRepository: AuthRepository {
    func loginWithKakao() async throws -> AuthTokens {
        try await Task.sleep(nanoseconds: 500_000_000)
        return AuthTokens(access: "stub-kakao-access", refresh: "stub-kakao-refresh")
    }
    func loginWithApple() async throws -> AuthTokens {
        try await Task.sleep(nanoseconds: 500_000_000)
        return AuthTokens(access: "stub-apple-access", refresh: "stub-apple-refresh")
    }
}
#endif
