import SwiftUI

@main
struct EncorelyApp: App {
    @StateObject private var container = DIContainer()   

    var body: some Scene {
        WindowGroup {
            AuthRoutingView()
                .environmentObject(container)       
        }
    }
}
