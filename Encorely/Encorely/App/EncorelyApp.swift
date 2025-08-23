import SwiftUI

@main
struct EncorelyApp: App {
    
    @StateObject private var authLink = AuthLinkHandler.shared
    @StateObject private var container = DIContainer()

    init() {
    #if DEBUG
            FontRegistrar.registerAll()
            DispatchQueue.main.async {
                FontRegistrar.dumpPretendard()
            }
    #endif
    }
    
    var body: some Scene {
        WindowGroup {
                 AuthRoutingView()
                .environmentObject(authLink)
                .environmentObject(container)
                .onOpenURL { url in
                    authLink.handle(url)
                }
        }
    }
}
