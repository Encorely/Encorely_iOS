import SwiftUI


struct AuthRoutingView: View {
    @StateObject private var router = AuthRouter()

    var body: some View {
        NavigationStack(path: $router.path) {
            SplashHost() // 시작은 스플래시(로고만)
                .navigationDestination(for: AuthRoute.self) { dest in
                    switch dest {
                    case .splash:
                        SplashHost()
                    case .onboarding:
                        OnboardingHost()
                    case .login:
                        LoginHost()
                    case .beforeProfileSetting:
                        BeforeProfileSettingHost()
                    case .tabs:
                        EncorelyTabView()
                    }
                }
        }
        .environmentObject(router)
    }
}


private struct SplashHost: View {
    @EnvironmentObject private var router: AuthRouter
    private let splashDuration: UInt64 = 3_000_000_000 // 3초

    var body: some View {
        SplashView()
            .task {
                // TODO: 토큰 유효하면 바로 홈 진입
                // if hasValidToken { router.replace(with: .tabs); return }
                try? await Task.sleep(nanoseconds: splashDuration)
                guard !Task.isCancelled else { return }
                withAnimation(.easeInOut) {
                    router.push(.onboarding)
                }
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
        LoginView(onLoginSuccess: {
            // 초기 프로필 설정 화면으로 이동
            router.replace(with: .beforeProfileSetting)
            // 만약 바로 홈이면: router.replace(with: .tabs)
        })
    }
}

/// 초기 프로필 설정 호스트
private struct BeforeProfileSettingHost: View {
    var body: some View {
        BeforeProfileSetting()   // 실제 화면 이름과 다르면 아래 “이름 확인” 참고
    }
}
