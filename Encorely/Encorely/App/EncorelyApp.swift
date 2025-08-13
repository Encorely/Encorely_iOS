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
            MainReviewRegistView()
                .environmentObject(container)
        }
    }
}
