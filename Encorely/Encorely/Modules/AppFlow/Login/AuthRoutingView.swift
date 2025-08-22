import SwiftUI

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

                    case .beforeProfileSetting:
                        BeforeProfileSetting().environmentObject(router)

                    case .tabs:
                        EncorelyTabView()
                    }
                }
        }
        .environmentObject(router)
    }
}

// MARK: - Hosts

private struct SplashHost: View {
    @EnvironmentObject private var router: AuthRouter
    private let splashDuration: UInt64 = 3_000_000_000

    var body: some View {
        SplashView()
            .task {
                try? await Task.sleep(nanoseconds: splashDuration)
                withAnimation(.easeInOut) { router.push(.onboarding) }
            }
    }
}

private struct OnboardingHost: View {
    @EnvironmentObject private var router: AuthRouter
    var body: some View {
        OnboardingView { withAnimation(.easeInOut) { router.push(.login) } }
    }
}

private struct LoginHost: View {
    @EnvironmentObject private var router: AuthRouter
    var body: some View {
        LoginView { withAnimation(.easeInOut) { router.replace(with: .beforeProfileSetting) } }
    }
}
