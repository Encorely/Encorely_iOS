import Foundation

@MainActor
final class AlarmViewModel: ObservableObject {
    @Published var unreadAlarms: [AlarmItem] = []
    @Published var recentAlarms: [AlarmItem] = []

    private let repository: AlarmRepository

    init(repository: AlarmRepository = StubAlarmRepository()) {
        self.repository = repository
        Task { await loadAlarms() }
    }

    func loadAlarms() async {
        do {
            unreadAlarms = try await repository.fetchUnreadAlarms()
            recentAlarms = try await repository.fetchRecentAlarms()
        } catch {
            print("❌ 알림 로딩 실패: \(error)")
        }
    }
}
