import SwiftUI

struct NoticeView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = NoticeViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // 상단 바 (UI 그대로)
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image("chevronLeft").resizable().frame(width: 30, height: 30)
                }
                Spacer()
                Text("공지사항").font(.headline)
                Spacer()
                Color.clear.frame(width: 30, height: 30)
            }
            .padding()
            .background(Color.white)

            Divider()

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(vm.notices) { notice in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(notice.title)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    Text(notice.date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button(action: { withAnimation { vm.toggle(notice.id) } }) {
                                    Image(vm.expandedID == notice.id ? "up" : "down")
                                        .resizable().frame(width: 30, height: 30)
                                }
                            }

                            if vm.expandedID == notice.id {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(notice.content, id: \.self) { line in
                                        Text(line).font(.body)
                                    }
                                }
                                .padding(.top, 4)
                            }
                        }
                        .padding()
                        Divider()
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview { NoticeView() }
