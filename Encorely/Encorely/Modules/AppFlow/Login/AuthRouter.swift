import SwiftUI


@MainActor
final class AuthRouter: ObservableObject {
    @Published var path: [AuthRoute] = []

    func push(_ d: AuthRoute)       { path.append(d) }
    func pop()                      { _ = path.popLast() }
    func popToRoot()                { path.removeAll() }
    func replace(with d: AuthRoute) { path = [d] }   
}
