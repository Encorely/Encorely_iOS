import SwiftUI

/// Login/Splash 전용 네비게이션 스택
struct AuthRoutingView: View {
    @StateObject private var router = AuthRouter()

    var body: some View {
        NavigationStack(path: $router.path) {
            SplashHost()
                .navigationDestination(for: AuthRoute.self) { dest in
                    switch dest {
                    case .splash:
                        SplashHost()
                    case .onboarding:
                        OnboardingHost()
                    case .login:
                        LoginHost()
                    case .tabs:
                        // 팀의 탭 루트로 교체
                        EncorelyTabView()
                    }
                }
        }
        .environmentObject(router)
    }
}

// MARK: - Hosts (UI 건드리지 않음)

private struct SplashHost: View {
    @EnvironmentObject private var router: AuthRouter
    var body: some View {
        SplashView()
            .task {
                // TODO: 토큰 체크 후 분기
                // if hasValidToken { router.replace(with: .tabs) } else { router.push(.onboarding) }
                router.push(.onboarding)
            }
    }
}

private struct OnboardingHost: View {
    @EnvironmentObject private var router: AuthRouter
    var body: some View {
        OnboardingView(onFinish: { router.push(.login) })
    }
}

private struct LoginHost: View {
    @EnvironmentObject private var router: AuthRouter
    var body: some View {
        LoginView(onLoginSuccess: { router.replace(with: .tabs) })
    }
}

#Preview {
    AuthRoutingView()
}
