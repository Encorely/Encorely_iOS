import SwiftUI

final class AuthRouter: ObservableObject {
    @Published var path: [AuthRoute] = []

    func push(_ dest: AuthRoute)       { path.append(dest) }
    func pop()                         { _ = path.popLast() }
    func popToRoot()                   { path.removeAll() }
    func replace(with dest: AuthRoute) { path = [dest] }
}
