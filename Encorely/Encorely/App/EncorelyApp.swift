//
//  EncorelyApp.swift
//  Encorely
//
//  Created by 이예지 on 7/7/25.
//

import SwiftUI

@main
struct EncorelyApp: App {
    
    @StateObject private var container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            EncorelyTabView()
                .environmentObject(container)
        }
    }
}
/*
@main
struct EncorelyApp: App {
    var body: some Scene {
        WindowGroup {
            AuthRoutingView()   // 임시로 인증 라우터를 루트로
        }
    }
}
*/
