import SwiftUI
import PhotosUI
import UIKit

struct ProfileSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = ProfileViewModel()

    @State private var isPhotoSheetPresented = false
    @State private var selectedItem: PhotosPickerItem?

    @State private var isNicknameValid: Bool? = nil

    var body: some View {
        VStack(spacing: 40) {
            // Top
            HStack {
                Button { dismiss() } label: {
                    Image("chevronLeft").resizable().frame(width: 30, height: 30)
                }
                Spacer()
                Text("프로필 설정").font(.headline)
                Spacer()
                Color.clear.frame(width: 24, height: 24)
            }
            .padding(.horizontal)
            .padding(.top, 12)

            // Image
            ZStack(alignment: .bottomTrailing) {
                // ✅ 기본 프로필(=editingImageData가 nil)일 땐 회색 원 배경 표시
                Circle()
                    .fill(vm.editingImageData == nil ? Color("grayColorH") : Color.clear)
                    .frame(width: 100, height: 100)

                Group {
                    if let data = vm.editingImageData, let ui = UIImage(data: data) {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image("Nothing")
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())

                Button { isPhotoSheetPresented = true } label: {
                    Image("plusCircle")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
            }
            .padding(.top, 8)

            // Nickname
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text("닉네임").font(.subheadline).fontWeight(.medium)
                    Text("*").foregroundColor(.red).font(.subheadline)
                }
                .padding(.horizontal)

                ZStack {
                    TextField("닉네임을 입력해주세요", text: $vm.editingNickname)
                        .padding(.leading, 16)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(Color("grayColorC"), lineWidth: 1)
                        )

                    HStack {
                        Spacer()
                        Button("중복 확인") {
                            let trimmed = vm.editingNickname
                                .trimmingCharacters(in: .whitespacesAndNewlines)
                            isNicknameValid = !trimmed.isEmpty
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color("mainColorB"))
                        .clipShape(Capsule())
                        .padding(.trailing, 12)
                    }
                }
                .padding(.horizontal)

                if let valid = isNicknameValid {
                    Text(valid ? "사용 가능한 닉네임이에요" : "사용 불가능한 닉네임이에요")
                        .font(.caption)
                        .foregroundColor(valid ? .blue : .red)
                        .padding(.leading, 24)
                }
            }

            // Intro
            VStack(alignment: .leading, spacing: 4) {
                Text("한 줄 소개")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal)

                TextField("나를 소개해주세요(최대 50자)", text: $vm.editingIntroduction)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color("grayColorC"), lineWidth: 1)
                    )
                    .padding(.horizontal)
            }

            // Link
            VStack(alignment: .leading, spacing: 4) {
                Text("개인 프로필 링크 추가")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal)

                TextField("ex. 인스타그램, 트위터, 스레드", text: $vm.editingLink)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .keyboardType(.URL)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color("grayColorC"), lineWidth: 1)
                    )
                    .padding(.horizontal)
            }

            Spacer()

            // Complete
            Button {
                Task {
                    await vm.save()
                    if case .success = vm.state { dismiss() }
                }
            } label: {
                Text("프로필 설정 완료")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color("mainColorB"))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .navigationBarHidden(true)

        // 저장된 값 로드
        .onAppear { vm.loadFromStore() }

        // 닉네임 변경 시, 중복확인 결과 초기화
        .onChange(of: vm.editingNickname) { _, _ in
            isNicknameValid = nil
        }

        // 사진 선택 시 Data로 반영
        .sheet(isPresented: $isPhotoSheetPresented) { photoSheet }
        .onChange(of: selectedItem) { _, newItem in
            guard let newItem else { return }
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    vm.editingImageData = data
                    isPhotoSheetPresented = false
                }
            }
        }

        // 에러 알림
        .alert("오류", isPresented: .constant({
            if case .failure = vm.state { return true } else { return false }
        }())) {
            Button("확인") { vm.state = .idle }
        } message: {
            if case let .failure(msg) = vm.state { Text(msg) } else { EmptyView() }
        }
    }

    private var photoSheet: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button { isPhotoSheetPresented = false } label: {
                    Image("xmark").resizable().frame(width: 24, height: 24).padding()
                }
            }
            Button {
                vm.editingImageData = nil
                isPhotoSheetPresented = false
            } label: {
                HStack {
                    Image("profileDefaultIcon").resizable().frame(width: 36, height: 36)
                    Text("기본 프로필 사진 적용").foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            PhotosPicker(selection: $selectedItem, matching: .images) {
                HStack {
                    Image("galleryIcon").resizable().frame(width: 36, height: 36)
                    Text("갤러리에서 사진 선택").foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            Spacer()
        }
        .presentationDetents([.height(220)])
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationStack { ProfileSettingView() }
}
