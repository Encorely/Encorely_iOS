//
//  NavigationRouter.swift
//  Encorely
//
//  Created by 이예지 on 7/23/25.
//

import Foundation

protocol NavigationRoutable {
    
    var destination: [NavigationDestination] { get set }
    
    /// 새로운 화면을 네비게이션 스택에 푸시
    func push(to view: NavigationDestination)
    
    /// 뒤로 가기
    func pop()
    
    /// 처음 화면으로 이동
    func popToRootView()
}

/// SwiftUI에서 상태를 추적할 수 있도록 Observable로 선언된 라우터 클래스
@Observable
class NavigationRouter: NavigationRoutable {
    
    /// 현재까지 쌓인 화면 목적지 목록 (화면 전환 상태)
    var destination: [NavigationDestination] = []
    
    /// 화면을 새로 추가 (푸시)
    /// - Parameter view: 이동할 화면을 나타내는 NavigationDestination
    func push(to view: NavigationDestination) {
        destination.append(view)
    }
    
    /// 뒤로 가기
    func pop() {
        _ = destination.popLast()
    }
    
    /// 루트 화면으로 이동
    func popToRootView() {
        destination.removeAll()
    }
}
