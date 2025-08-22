import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = SettingViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // 상단바
            HStack {
                Button(action: { dismiss() }) {
                    Image("chevronLeft")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.grayColorA)
                }
                Spacer()
                Text("설정")
                    .font(.headline)
                Spacer()
                Color.clear.frame(width: 30, height: 30)
            }
            .padding()
            .background(Color.white)

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    // ✅ 알림 설정
                    VStack(alignment: .leading, spacing: 16) {
                        Text("알림설정")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Toggle(isOn: $vm.serviceAlert) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("서비스 이용 알림")
                                Text("이용 내역, 서비스 진행사항 알림")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .tint(Color("mainColorB"))

                        Toggle(isOn: $vm.eventAlert) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("쿠폰, 이벤트 등 혜택 알림")
                                Text("광고성 정보 수신 동의에 의한 혜택 관련 알림")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .tint(Color("mainColorB"))
                    }
                    .padding(.horizontal)

                    // ✅ 메뉴 목록
                    VStack(spacing: 0) {
                        SettingRow(title: "공지사항", destination: NoticeView())
                        SettingRow(title: "문의하기", destination: NoticeView())
                        SettingRow(title: "서비스 이용약관", destination: NoticeView())
                        SettingRow(title: "차단된 계정", destination: BlockedListView())

                        SettingButtonRow(title: "로그아웃") { vm.logout() }
                        SettingButtonRow(title: "회원탈퇴") { vm.withdraw() }

                        HStack {
                            Text("버전 정보")
                            Spacer()
                            Text("1.0")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                    }
                }
                .padding(.top)
            }
        }
        .navigationBarHidden(true)
    }
}

// 재사용 셀들(그대로)
struct SettingRow<Destination: View>: View {
    let title: String
    let destination: Destination
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(title).foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
    }
}

struct SettingButtonRow: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title).foregroundColor(.black)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    NavigationStack { SettingView() }
}
