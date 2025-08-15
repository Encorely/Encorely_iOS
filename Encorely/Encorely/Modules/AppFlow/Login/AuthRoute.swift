import Foundation

/// 로그인/스플래시 플로우 전용 목적지
enum AuthRoute: Hashable {
    case splash
    case onboarding
    case login
    case tabs   // 앱의 탭 루트(홈)
}
