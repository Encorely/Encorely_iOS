import SwiftUI


@main
struct EncorelyApp: App {

    @StateObject private var authLink = AuthLinkHandler.shared

    var body: some Scene {
        WindowGroup {
            AuthRoutingView()
                .environmentObject(authLink) 
                .onOpenURL { url in
                    authLink.handle(url)
                }
        }
    }
}

