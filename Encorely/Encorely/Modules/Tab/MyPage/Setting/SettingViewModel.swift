//
//  SettingViewModel.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

final class SettingViewModel: ObservableObject {
    @Published var serviceAlert: Bool {
        didSet { UserDefaults.standard.set(serviceAlert, forKey: "serviceAlert") }
    }
    @Published var eventAlert:   Bool {
        didSet { UserDefaults.standard.set(eventAlert,   forKey: "eventAlert") }
    }

    init() {
        // 저장된 값이 없으면 기본값: 서비스 알림 ON, 혜택 알림 OFF
        self.serviceAlert = UserDefaults.standard.object(forKey: "serviceAlert") as? Bool ?? true
        self.eventAlert   = UserDefaults.standard.object(forKey: "eventAlert")   as? Bool ?? false
    }

    // 추후 서버 동기화가 필요하면 여기서 API 호출만 추가해주면 됨.
    func logout() { /* TODO: 서버 연동시 구현 */ }
    func withdraw() { /* TODO: 서버 연동시 구현 */ }
}
