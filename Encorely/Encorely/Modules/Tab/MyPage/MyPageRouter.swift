//
//  MyPageRouter.swift
//  Encorely
//
//  Created by Kehyuk on 8/13/25.
//

import SwiftUI

/// MyPage 탭 전용 라우터 (다른 팀 화면에 영향 없음)
final class MyPageRouter: ObservableObject {
    @Published var path: [MyPageRoute] = []

    func push(_ route: MyPageRoute) { path.append(route) }
    func pop() { _ = path.popLast() }
    func popToRoot() { path.removeAll() }
}
