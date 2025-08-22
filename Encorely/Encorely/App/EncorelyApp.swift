import SwiftUI

@main
struct EncorelyApp: App {
    @StateObject private var container = DIContainer()   // ★ 루트에서 생성

    var body: some Scene {
        WindowGroup {
            AuthRoutingView()
                .environmentObject(container)           // ★ 전역 주입
        }
    }
}
