//
//  EncorelyApp.swift
//  Encorely
//
//  Created by 이예지 on 7/7/25.
//

import SwiftUI

/*@main
@StateObject private var container = DIContainer()

struct EncorelyApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainReviewRegistView()
                .environmentObject(container)
        }
    }
}
*/
@main
struct EncorelyApp: App {
    var body: some Scene {
        WindowGroup {
            AuthRoutingView()   // 임시로 인증 라우터를 루트로
        }
    }
}
